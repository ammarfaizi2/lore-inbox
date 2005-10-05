Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030368AbVJEUXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030368AbVJEUXV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 16:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030369AbVJEUXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 16:23:20 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:63681 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1030368AbVJEUXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 16:23:20 -0400
Date: Wed, 5 Oct 2005 16:23:19 -0400
To: Marc Perkel <marc@perkel.com>
Cc: Florin Malita <fmalita@gmail.com>, nix@esperi.org.uk, 7eggert@gmx.de,
       lkcl@lkcl.net, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051005202319.GM7949@csclub.uwaterloo.ca>
References: <4U0XH-3Gp-39@gated-at.bofh.it> <E1EMutG-0001Hd-7U@be1.lrz> <87k6gsjalu.fsf@amaterasu.srvr.nix> <4343E611.1000901@perkel.com> <20051005144441.GC8011@csclub.uwaterloo.ca> <4343E7AC.6000607@perkel.com> <20051005153727.994c4709.fmalita@gmail.com> <43442D19.4050005@perkel.com> <20051005195212.GJ7949@csclub.uwaterloo.ca> <4344320A.7090007@perkel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4344320A.7090007@perkel.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2005 at 01:05:30PM -0700, Marc Perkel wrote:
> What you don't understand is that Netware's permissions mechanish is 
> totally different that Linux. A hard link in Netware wouldn't inherit 
> rights the way Linux does. So the user would have rights to their hard 
> link to delete that link without having rights to unlink the file.
> 
> This is an important concept so pay attention. Linux stores all the 
> permission to a file with that file entry. Netware doesn't. Netware 
> calculates effective rights from the parent directories and it is all 
> inherited unless files or directoies are explicitly set differently. So 
> if files are added to other people folders then those people get rights 
> to it automatically without having to go to the second step of changing 
> the file's permissions.

So if you were to moint a partition on /mnt, does the mounted thing now
have to inherit permissions from / and /mnt or from it's own root or
what?

If you chroot something, does it have access to checking permissions
past it's 'virtual' root?

Can users make hardlinks themselves on netware or does an admin have to
do it?

It seems rather inefficient to have to read 8 directories worth of
permissions and calculate them together if you have a file 8 directories
deep compared to doing a single read and compare against a 16bit value +
uid/gid check (ACL of course makes this more complex, but still only
involves reading permissions in one place since inherited permissions
are for create time, not access time).

Unix offers features netware doesn't and some of them require
permissions to work a certain way.

Len Sorensen
