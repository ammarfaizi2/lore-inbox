Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263842AbRFDM3W>; Mon, 4 Jun 2001 08:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264226AbRFDM3N>; Mon, 4 Jun 2001 08:29:13 -0400
Received: from docs3.abcrs.com ([63.238.77.222]:11784 "EHLO
	mailer.progressive-comp.com") by vger.kernel.org with ESMTP
	id <S263842AbRFDM3D>; Mon, 4 Jun 2001 08:29:03 -0400
Date: Mon, 4 Jun 2001 08:28:46 -0400
Message-Id: <200106041228.IAA08746@mailer.progressive-comp.com>
From: Hank Leininger <linux-kernel@progressive-comp.com>
Reply-To: Hank Leininger <hlein@progressive-comp.com>
To: linux-kernel@vger.kernel.org
Subject: Re: symlink_prefix
X-Shameless-Plug: Check out http://marc.theaimsgroup.com/
X-Warning: This mail posted via a web gateway at marc.theaimsgroup.com
X-Warning: Report any violation of list policy to abuse@progressive-comp.com
X-Posted-By: Hank Leininger <hlein@progressive-comp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2001-06-03, Andries.Brouwer@cwi.nl wrote:

> Suppose I have devices /dev/a, /dev/b, /dev/c that contain the
> /, /usr and /usr/spool filesystems for FOO OS. Now
>         mount /dev/a /mnt -o symlink_prefix=/mnt
>         mount /dev/b /mnt/usr -o symlink_prefix=/mnt
>         mount /dev/c /mnt/usr/spool -o symlink_prefix=/mnt

Cool.

What happens when someone creates new absolute symlinks under /mnt ?
Will/should the magic /mnt/ header be stripped from any symlink created
under such a path-translated volume?  The answer is probably 'yes', but
either one violates POLA :(

--
Hank Leininger <hlein@progressive-comp.com> 
  
