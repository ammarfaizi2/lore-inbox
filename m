Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131795AbRAVGVW>; Mon, 22 Jan 2001 01:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131891AbRAVGVN>; Mon, 22 Jan 2001 01:21:13 -0500
Received: from 513.holly-springs.nc.us ([216.27.31.173]:10079 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S131795AbRAVGVI>; Mon, 22 Jan 2001 01:21:08 -0500
Message-ID: <002c01c08454$751eb580$8501a8c0@gromit>
From: "Michael Rothwell" <rothwell@holly-springs.nc.us>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: "Mo McKinlay" <mmckinlay@gnu.org>, "Peter Samuelson" <peter@cadcamlab.org>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <200101210727.f0L7RO3258994@saturn.cs.uml.edu>
Subject: Re: named streams, extended attributes, and posix
Date: Mon, 22 Jan 2001 01:19:43 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What you say is true; but Win32 -- which pretty much all Windows apps use --
disallows the following:

\/:*?"<>|

... from that, they chose ":" as the stream delimiter, since the only other
place it is used is with the drive letters. For the user, and most
(non-native, i.e., Win32) apps, there are limitations on what a filename can
contain.

-M

----- Original Message -----
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: "Michael Rothwell" <rothwell@holly-springs.nc.us>
Cc: "Mo McKinlay" <mmckinlay@gnu.org>; "Peter Samuelson"
<peter@cadcamlab.org>; <linux-kernel@vger.kernel.org>
Sent: Saturday, January 20, 2001 11:27 PM
Subject: Re: named streams, extended attributes, and posix


> Michael Rothwell writes:
> > ...
> >> Today, Michael Rothwell (rothwell@holly-springs.nc.us) wrote:
>
> >>> The filesystem, when registering that it supports the "named streams"
> >>> namespace, could specify its preferred delimiter to the VFS as well.
> >>> Ext4 could use /directory/file/stream, and NTFS could use
> >>> /directory/file:stream.
> ...
> > Oh, undoubtedly.  But NTFS already disallows several characters
> > in valid filenames.
>
> NTFS allows all 16-bit characters in filenames, including 0x0000.
> Nothing is disallowed. The NT kernel's native API uses counted
> Unicode strings. The strings can be huge too, like 128 kB.
>
> So there isn't _any_ safe delimiter.
>
> Win32 will choke on 0x0000 and a few other things, allowing a
> clever person to create apparently inaccessible files.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
