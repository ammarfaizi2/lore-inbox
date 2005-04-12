Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262454AbVDLPKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbVDLPKH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 11:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbVDLPG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 11:06:56 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:27491 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262443AbVDLPC1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 11:02:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=elDVpvH3YJr1u9dwmZz9GvXqzFLD4BdHvc6GatGme9xStMc70Unz5d1DMYZNrAuPCO8C1t04hWTOsGmT7sI+zrgtJ8+SiEtu5++w9ivmzjlNy0+M4g7PO5agBtf6YwY7uFhcJmbdDa/sSlCIU4byrH9YiqSpa42Z5YOwNQgPxBs=
Message-ID: <e3da09a70504120802622d3625@mail.gmail.com>
Date: Tue, 12 Apr 2005 11:02:23 -0400
From: Dan Berger <danberger@gmail.com>
Reply-To: Dan Berger <danberger@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Error When Booting: Resize Inode Not Valid
Cc: "Theodore Ts'o" <tytso@mit.edu>
In-Reply-To: <20050412140757.GB9684@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <e3da09a705041205176403fe27@mail.gmail.com>
	 <20050412140757.GB9684@thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ted, thank you so much for responding. I sincerely appreciate it.

I went ahead and upgraded my e2fsprogs package (1.37 is actually
available on the fc3 dev repo) and reran fsck.ext3. I once again
answered yes to the question: "Recreate resize inode?"

Unfortunately, on the next reboot, I was once again given the same
error "Resize inode not valid" and dropped to the repair filesystem.

I hope you or someone else can shed some more light on this. I really
believe this is something that can be fixed without any extraordinary
measures (IE start over)

Thanks again for your kind and prompt response

Sincerely,

Dan Berger

On Apr 12, 2005 10:07 AM, Theodore Ts'o <tytso@mit.edu> wrote:
> On Tue, Apr 12, 2005 at 08:17:46AM -0400, Dan Berger wrote:
> > Hello. I have recently switched to Linux to prevent any big errors...
> > but I guess I just have bad luck :)
> >
> > Distro: Fedora Core 3
> > Kernel: 2.6.10-1.FC3_770
> > File system: ext3
> > Mobo: Gigabyte GA7VAXP+
> >
> > This morning I went to reboot my machine normally after an 8 day
> > uptime. At boot, when it checked the root partition's integrity, I got
> > the error "Resize inode not valid" and I was dropped to the repair fs
> > console.
> >
> > I ran fsck.ext3 numerous times, always answering yes to recreating the
> > resize inode... but to no avail. I even tried doing this from FC3's
> > rescue CD.
> 
> It looks like there is a bug in FC3's e2fsck program which is failing
> to fix the filesystem corruption.  (FC3's e2fsck had resize2fs support
> more-or-less hacked in, and it didn't support big endian systems, and
> it had a whole host of other problems.)
> 
> I would recommend upgrading to the latest version of e2fsck (1.37)
> which should be able to fix it.  If not, please see the REPORTING BUGS
> section of the e2fsck man page to see the sort of information I would
> need to see in order to fix it.
> 
> Unfortunately, FC3 doesn't have a prebuilt version of the latest
> e2fspros, so you would have to build it yourself.
> 
>                                                 - Ted
>
