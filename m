Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbULYU1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbULYU1K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 15:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbULYU1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 15:27:10 -0500
Received: from quechua.inka.de ([193.197.184.2]:43214 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261560AbULYU1J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 15:27:09 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: signal.c: convert assertion to BUG_ON()
References: <20041225172939.GA7495@elf.ucw.cz>
Organization: private Linux site, southern Germany
Date: Sat, 25 Dec 2004 21:25:57 +0100
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E1CiIU9-0006yK-00@bigred.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -	if (sig == -1)
> -		BUG();
> +	BUG_ON(sig == -1);

Can sig be < -1? If not, this should probably be BUG_ON(sig < 0)
(common defensive coding rule...)

Olaf

