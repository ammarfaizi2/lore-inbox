Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262617AbRFBQrv>; Sat, 2 Jun 2001 12:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262618AbRFBQrl>; Sat, 2 Jun 2001 12:47:41 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:9992 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S262617AbRFBQr0> convert rfc822-to-8bit; Sat, 2 Jun 2001 12:47:26 -0400
Date: Sat, 02 Jun 2001 12:42:04 -0400
From: Chris Mason <mason@suse.com>
To: Andreas Hartmann <andihartmann@freenet.de>,
        =?ISO-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
cc: Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.5 and all ac-Patches] massive file corruption with reiser
 or NFS
Message-ID: <273360000.991500124@tiny>
In-Reply-To: <01060214363800.02172@athlon>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Saturday, June 02, 2001 02:41:04 PM +0200 Andreas Hartmann
<andihartmann@freenet.de> wrote:

> Am Samstag,  2. Juni 2001 12:52 schrieb Rasmus Bøg Hansen:
>> On Sat, 2 Jun 2001, Andreas Hartmann wrote:
>> > I got massive file corruptions with the kernels mentioned in the
>> > subject. I can reproduce it every time.
>> >> You cannot use NFS on reiserfs unless you apply the knfsd patch. Look at
>> www.namesys.com.
> > Thank you very much for your advice.
> > I tested your suggestion and run the machine without NFS-mounted devices
> - it  seems to be working fine. > > Anyway - I'm wondering why I didn't get any problem until 2.4.4ac10 with
> this  configuration without the appropriate patch on the client or on the
> server?

The problem only happens when the clients do an operation on a file that
has gone out of cache on the server.  Under light load, this might happen
very rarely.

You only need the patch on the server.

-chris

