Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbVFAQLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVFAQLr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 12:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbVFAQLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 12:11:04 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:3446 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261453AbVFAQJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 12:09:23 -0400
From: Blaisorblade <blaisorblade@yahoo.it>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [patch 1/1] kconfig: trivial cleanup
Date: Wed, 1 Jun 2005 18:11:36 +0200
User-Agent: KMail/1.8.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
References: <20050529174525.A36D7A2FA3@zion.home.lan> <200505312235.35234.blaisorblade@yahoo.it> <Pine.LNX.4.61.0506010149070.3728@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0506010149070.3728@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506011811.37456.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 June 2005 01:50, Roman Zippel wrote:
> Hi,
>
> On Tue, 31 May 2005, Blaisorblade wrote:
> > I can regenerate it only with bison 2.0, since that's what I have
> > installed. So if you don't want it to be regenerated, you cannot accept
> > my patch. I proposed sending two patches to avoid mixing the bison
> > changes with this patch changes, that's all.
>
> What I meant is a patch like this:
Ok, yes... akpm, can you merge it?
> Index: linux-2.6-mm/scripts/kconfig/zconf.tab.c_shipped
> ===================================================================
> --- linux-2.6-mm.orig/scripts/kconfig/zconf.tab.c_shipped	2005-03-16
> 13:47:36.000000000 +0100 +++
> linux-2.6-mm/scripts/kconfig/zconf.tab.c_shipped	2005-06-01
> 01:48:19.000000000 +0200 @@ -1531,7 +1531,7 @@ yyreduce:
>
>      {
>  	menu_add_entry(NULL);
> -	menu_add_prop(P_MENU, yyvsp[-1].string, NULL, NULL);
> +	menu_add_prompt(P_MENU, yyvsp[-1].string, NULL);
>  	printd(DEBUG_PARSE, "%s:%d:menu\n", zconf_curname(), zconf_lineno());
>  ;}
>      break;
> @@ -1586,7 +1586,7 @@ yyreduce:
>
>      {
>  	menu_add_entry(NULL);
> -	menu_add_prop(P_COMMENT, yyvsp[-1].string, NULL, NULL);
> +	menu_add_prompt(P_COMMENT, yyvsp[-1].string, NULL);
>  	printd(DEBUG_PARSE, "%s:%d:comment\n", zconf_curname(), zconf_lineno());
>  ;}
>      break;
> @@ -1640,7 +1640,7 @@ yyreduce:
>    case 86:
>
>      {
> -	menu_add_prop(P_PROMPT, yyvsp[-1].string, NULL, yyvsp[0].expr);
> +	menu_add_prompt(P_PROMPT, yyvsp[-1].string, yyvsp[0].expr);
>  ;}
>      break;
>
> @@ -1925,7 +1925,7 @@ void conf_parse(const char *name)
>  	sym_init();
>  	menu_init();
>  	modules_sym = sym_lookup("MODULES", 0);
> -	rootmenu.prompt = menu_add_prop(P_MENU, "Linux Kernel Configuration",
> NULL, NULL); +	rootmenu.prompt = menu_add_prompt(P_MENU, "Linux Kernel
> Configuration", NULL);
>
>  	//zconfdebug = 1;
>  	zconfparse();
>
> bye, Roman

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
