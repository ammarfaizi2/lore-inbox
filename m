Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263225AbRFRAgR>; Sun, 17 Jun 2001 20:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263228AbRFRAgH>; Sun, 17 Jun 2001 20:36:07 -0400
Received: from line153.ba.psg.sk ([195.80.179.153]:11651 "HELO ivan.doma")
	by vger.kernel.org with SMTP id <S263225AbRFRAf7>;
	Sun, 17 Jun 2001 20:35:59 -0400
Date: Mon, 18 Jun 2001 02:34:59 +0200
From: Ivan Vadovic <pivo@pobox.sk>
To: Riley Williams <rhw@MemAlpha.CX>
Cc: linux-kernel@vger.kernel.org
Subject: Re: any good diff merging utility?
Message-ID: <20010618023459.C1063@ivan.doma>
In-Reply-To: <20010618014547.B1063@ivan.doma> <Pine.LNX.4.33.0106180102520.25038-100000@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.33.0106180102520.25038-100000@infradead.org>; from rhw@MemAlpha.CX on Mon, Jun 18, 2001 at 01:06:54AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > I like to build kernels with a bunch of patches on top to test
>  > new stuff. The problem is that it takes a lot of effort to fix
>  > all the failed hunks during patching that really wouldn't have
>  > to be failed if only patch was a little more inteligent and
>  > could merge several patches into one ( if possible) or if could
>  > take into account already applied patches.
> 
> The basic problem here is that the "failed hunks" are usually there
> because of conflicts between the two patches in question, and as a
> result, they are not as easy to merge automagically as one might at
> first assume.

Very often the case is that they indeed can be merged automagically.
For example two patches inserting few lines right after the #include
lines.

patch1:
@@ 10,1 10,2 @@
 #include <foo.h>
+#include <1.h>

patch2:
@@ 10,1 10,2 @@
 #include <foo.h>
+#include <2.h>

The patch will fail to patch :-). But there is no real conflict between
the patches.
 
>  > Well, are there any utilities to merge diffs? I couldn't find
>  > any on freshmeat. So what are you using to stack many patches
>  > onto the kernel tree? Just manualy modify the diff? I'll try to
>  > write something more automatic if nothing comes up.
> 
> I once came across a utility called "diff3" that was designed to take
> a patch for one version of a package and create an equivalent patch
> for another version of the same package, but I haven't been able to
> find it again since my hard drive crashed.

diff3 comes from gnu diffutils
<ftp://ftp.gnu.org/gnu/diffutils/diffutils-2.7.tar.gz>. But all it does
is comparing three FILES for differencies.

Ivan Vadovic
