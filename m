Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbVITW6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbVITW6n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 18:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbVITW6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 18:58:43 -0400
Received: from rwcrmhc12.comcast.net ([204.127.198.43]:28102 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750735AbVITW6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 18:58:42 -0400
Message-ID: <433093F5.4060808@comcast.net>
Date: Tue, 20 Sep 2005 18:57:57 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050912)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jesper.juhl@gmail.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Hot-patching
References: <43308815.1000200@comcast.net> <9a87484905092015471c2dc329@mail.gmail.com>
In-Reply-To: <9a87484905092015471c2dc329@mail.gmail.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Jesper Juhl wrote:
> On 9/21/05, John Richard Moser <nigelenki@comcast.net> wrote:
> [snip]
> 
>>Besides getting rid of a pet peeve of mine (more rebooting than
>>absolutely necessary) and giving a way to continuously increase the size
>>of the running kernel with each bugfix, this has implications on servers
>>that don't want to reboot for whatever reason.  For enterprise
>>applications, it would be possible to fix a kernel bug or security hole
>>that hasn't been triggered by loading a module with the bugfixes,
>>effectively hot-patching the kernel.
>>
> 
> [snip]
> 
> If you have uptime demands like that I think a much better approach
> would be to make sure the box is heavily firewalled so importance of
> the security of the host itself drops. If there's no way to get to a
> box in a way that enables you to actually exploit a security hole,
> then it doesn't matter much that the hole is there at all.

Yeah.  Not always feasible though; let's say the bug manifests in
something Apache tells the kernel to do (there's quite a lot of
syscalls) based on stuff passed to CGI scripts.  Firewalls and
everything, but slide in a "legitimate" port 80 or port 443 access and BLAM.

Shell servers like compile farms are also interesting, if you want to
talk about firewalling not being all that great.  That's of course if
you care about local attacks; personally if I have 10000 employees or
clients using a machine I don't want to trust them all to be nice.

> 
> Another option would be a clustered setup where you normally run the
> app(s) on nodeA, nodeB ... nodeN, then when you need to upgrade you
> move all running applications off of nodeA and upgrade it, move
> everything off of nodeB and then upgrade that, repeat for nr of nodes,
> finally redistribute the load properly again.
> 
> 

Beautiful setup that, and surprisingly cost effective if 1) you can do
it yourself, and 2) you're using just 2 nodes.  I'd prefer 3 nodes for a
minimal set-up of course, so if I upgrade one and the other goes down I
still have a third; I'm obsessive about perfectly stable environments,
it has to be able to stand up to a bomb blast or the ending scene from
Hackers with all the blackhats in the world tearing ass at the system.


- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDMJPzhDd4aOud5P8RAhMNAJ9zQXu8qBenrVOpUhobqNoaht/svACgji8P
klO1Shq2h9o/dWb4iza1adw=
=OL8+
-----END PGP SIGNATURE-----
