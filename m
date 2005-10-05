Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030351AbVJETwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030351AbVJETwN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 15:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030352AbVJETwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 15:52:13 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:19644 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1030351AbVJETwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 15:52:13 -0400
Date: Wed, 5 Oct 2005 15:52:12 -0400
To: Marc Perkel <marc@perkel.com>
Cc: Florin Malita <fmalita@gmail.com>, nix@esperi.org.uk, 7eggert@gmx.de,
       lkcl@lkcl.net, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051005195212.GJ7949@csclub.uwaterloo.ca>
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it> <E1EMutG-0001Hd-7U@be1.lrz> <87k6gsjalu.fsf@amaterasu.srvr.nix> <4343E611.1000901@perkel.com> <20051005144441.GC8011@csclub.uwaterloo.ca> <4343E7AC.6000607@perkel.com> <20051005153727.994c4709.fmalita@gmail.com> <43442D19.4050005@perkel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43442D19.4050005@perkel.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2005 at 12:44:25PM -0700, Marc Perkel wrote:
> What you don't get is that if you don't have rights to write to a file 
> then you shouldn't have the right to delete the file.  Once you get past 
> the "inside the box" Unix thinking you'll see the logic in this. So what 
> if the process of deleting a file involves writing to it. That's not 
> relevant.

When a system supports hardlinks, it IS relevant.

So if I decide I want a link to a file like say /etc/group in my home
dir (let us pretend they are on the same partition) so I make a hardlink
to it in my home dir and end up with a file still owned by root (since I
shouldn't be able to add me as owner to the file just by linking to it
after all).  Should I now have to go bother the admin about deleting the
file from my home dir if I decide that wasn't really what I wanted?  If
I didn't have write permissions to the dir I wouldn't have been able to
make the link in the first place, so since I made it I should be able to
delete it, and I can with the unix way of doing things.  I still can't
edit it anymore than I could in the original place since it linked with
the new link to the file having the excact same permissions as the
original.  Only someone like root can go chance the owner of a hardlink
to someone else and start setting up some interesting file permissions
using multiple hardlinks to one file.

I suspect you can't do that on netware, so you would have to add
explicit permissions for each user to a single copy of the file instead,
and you would probably want them all to have read/write access but in
fact NOT have delete permissions.

Len Sorensen
