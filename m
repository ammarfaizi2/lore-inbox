Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280035AbRLEF4D>; Wed, 5 Dec 2001 00:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280307AbRLEFzx>; Wed, 5 Dec 2001 00:55:53 -0500
Received: from ns1.calixo.net ([213.166.201.1]:5650 "EHLO ns1.rmcnet.fr")
	by vger.kernel.org with ESMTP id <S280035AbRLEFzj>;
	Wed, 5 Dec 2001 00:55:39 -0500
Date: Wed, 5 Dec 2001 06:55:09 +0100
To: linux-kernel@vger.kernel.org
Subject: Gradual VM-related freeze in 2.4.16,17-pre2 !
Message-ID: <20011205055509.GB11283@calixo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
X-Face: "99`N"mZV/:<T->OLp[>#d3R;u.!ivtwAEpIQDL8rD#;L3Wm)~^)Uv=#;S!LZf1y8oRY7J#JR\Lr{*4Cn*32C89ln>0~5~tm--}j%hvhj+vtW><xbwA=@G8M||zPV0-r`:6zhMqq+_OC_0W*-:Wxzm3%|A5EE}VFnIgRU=+,L-hGdM"j&l'_^zK+%MBOsdmi#e3(3fGg^SGM
From: Cyrille Chepelov <cyrille@chepelov.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I've converted yesterday my router, which until now had been happily running
ext2+2.4.13-pre2 on 8 MB of RAM + 200 MB of swap, to the ext3 + 2.4.16 (and
2.4.17-pre2) combinations (still eight megs of RAM, unfortunately 8-bit
SIMMs ain't cheap nowadays).

Now, as soon as the system gets some use (inetd kicks exim in, one ssh
attempt, etc.), most processes go freeze themselves into 
  <shrink_caches +57/80>
I can very temporarily regain some control over the system by SAKing it, but
eventually, everything userland is frozen up (packets still get routed, but
after a while I get a load of netfilter-related messages questioning Rusty's
sanity, which I'm willing to ignore as long as the VM is misbehaving).

Going a little backwards, to 2.4.13-ac8 (of course) solves the problem (but
incidentally, the interactive feel is much worse than what 2.4.16 gives 
before it freezes).

What can I do to further isolate the problem ? 

Thanks for any help.
	
	-- Cyrille

-- 
Grumpf.

