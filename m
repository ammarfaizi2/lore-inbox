Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318310AbSH0Ayn>; Mon, 26 Aug 2002 20:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318314AbSH0Ayn>; Mon, 26 Aug 2002 20:54:43 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:27779 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S318310AbSH0Aym>;
	Mon, 26 Aug 2002 20:54:42 -0400
Date: Tue, 27 Aug 2002 02:58:54 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Anton Blanchard <anton@samba.org>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Cc: vojtech@suse.cz
Subject: Re: dangling else in drivers/charConfig.in
Message-ID: <20020827025854.A28153@ucw.cz>
References: <20020826154247.A26399@dp.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020826154247.A26399@dp.samba.org>; from anton@samba.org on Mon, Aug 26, 2002 at 03:42:48PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2002 at 03:42:48PM -0400, Anton Blanchard wrote:

> Hi Vojtech,
> 
> Im busy chasing ppc64 breakage but I thought Id email you in case
> you didnt see the dangling else after removing PS2 keyboard
> support option :)
> 
> Anton

Linus, here's a fix:


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.514, 2002-08-27 02:57:46+02:00, vojtech@suse.cz
  Fix a dangling 'else' after removing ps/2 keyboard support.
  Found by Anton Blanchard.

 Config.in |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/char/Config.in b/drivers/char/Config.in
--- a/drivers/char/Config.in	Tue Aug 27 02:58:03 2002
+++ b/drivers/char/Config.in	Tue Aug 27 02:58:03 2002
@@ -57,7 +57,7 @@
    bool 'Enable Qtronix 990P Keyboard Support' CONFIG_QTRONIX_KEYBOARD
    if [ "$CONFIG_QTRONIX_KEYBOARD" = "y" ]; then
      define_bool CONFIG_IT8172_CIR y
-   else
+   fi
    bool 'Enable Smart Card Reader 0 Support ' CONFIG_IT8172_SCR0
    bool 'Enable Smart Card Reader 1 Support ' CONFIG_IT8172_SCR1
 fi

===================================================================

This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch28171
M'XL(`)O.:CT``\V46V_;(!3'G\.G.%(?^E#%!AN,8\E3VW0W=5*C3/T`Q":Q
M%QLL@[.E\H<?]J*V2K=4NSP,$.)R#OPYYR?.X-[(-IGL]!<KLP*=P0=M;#(Q
MG9%>]N#F2ZW=W"]T+?V#E;_:^J5J.HO<_D+8K("=;$TR(5[XN&+WC4PFR[?O
M[S]=+1%*4Y@70FWD9VDA39'5[4Y4N;D4MJBT\FPKE*FE%5ZFZ_[1M`\P#EQE
MA(>813V),.5]1G)"!"4RQP&-(XH.PBX/LH_]XX!C3&>,]RS`/$0W0#Q&*.#`
MQ[$?<#=(&$]H=.$&&,/1<7!!8(K1-?Q;T7.4P;OR&PC(G6-5J@V<R\K(<Q!K
M*UMH9:UWPVIC_`"V<K_2HLW!=$VC6^L-WKI3.:SV<*6L5G!="945SL9#MS"\
ME*#%4]31]#<+0EA@].:55^=M.23?'R[VYUJMRXU7JF<AH"[T/6%QQ/O9C,62
M,A+**,QX=!SGDV>-.62<ACWE..`C43^W?QVOO]#\`K73F@GA.`ICISF@;.0N
M?(E=>`([\M]A=PL_$G`'T_;KV!PJBU_DX@^@NXDP$/1Q[`%@73[],EDALZWI
1ZI2$C%$9Y>@[?.@!EL`$````
`
end

-- 
Vojtech Pavlik
SuSE Labs
