Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285031AbRLQG0p>; Mon, 17 Dec 2001 01:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285023AbRLQG0g>; Mon, 17 Dec 2001 01:26:36 -0500
Received: from arsenal.visi.net ([206.246.194.60]:3731 "EHLO visi.net")
	by vger.kernel.org with ESMTP id <S285031AbRLQG0U>;
	Mon, 17 Dec 2001 01:26:20 -0500
X-Virus-Scanner: McAfee
Date: Mon, 17 Dec 2001 01:26:14 -0500
From: Ben Collins <bcollins@debian.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        sparc-linux@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 1.11 is available
Message-ID: <20011217012613.C377@blimpo.internal.net>
In-Reply-To: <20011217002812.A377@blimpo.internal.net> <5132.1008568493@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="hQiwHBbRI9kgIhsi"
Content-Disposition: inline
In-Reply-To: <5132.1008568493@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 17, 2001 at 04:54:53PM +1100, Keith Owens wrote:
> On Mon, 17 Dec 2001 00:28:12 -0500, 
> Ben Collins <bcollins@debian.org> wrote:
> >If anyone needs them, I can provide a small diff for the sparc/sparc64
> >Vger CVS changes to apply on top of the main kbuild-2.5 patch. Very
> >minor change (hint, in Vger, netlink is compiled unconditionally now).
> 
> Since they are small, mail them to linux-{kernel,kbuild} and maybe the
> sparc lists as well.

Note, I have not updated to your current tree, so hopefully
net/netlink/Makefile.in hasn't changed. The patch is pretty easy to
apply by hand of course :)


Ben

-- 
 .----------=======-=-======-=========-----------=====------------=-=-----.
/                   Ben Collins    --    Debian GNU/Linux                  \
`  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'

--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="vger-kbuild-2.5.diff"

--- Makefile.in~	Mon Dec 17 01:24:10 2001
+++ Makefile.in	Wed Nov 21 10:31:06 2001
@@ -5,4 +5,4 @@
 expsyms(af_netlink.o)
 objlink(netlink.o af_netlink.o)
 select(CONFIG_NETLINK_DEV netlink_dev.o)
-select(CONFIG_NETLINK netlink.o)
+select(netlink.o)

--hQiwHBbRI9kgIhsi--
