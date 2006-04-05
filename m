Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbWDEIeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWDEIeL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 04:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWDEIeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 04:34:11 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:19082 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S1750823AbWDEIeK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 04:34:10 -0400
Date: Wed, 5 Apr 2006 10:32:04 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Martin Samuelsson <sam@home.se>
Cc: Adrian Bunk <bunk@stusta.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org
Message-ID: <20060405083204.GA5058@linuxtv.org>
References: <20060404014504.564bf45a.akpm@osdl.org> <20060404163001.GO6529@stusta.de> <20060404203219.40fe6b4c.sam@home.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060404203219.40fe6b4c.sam@home.se>
User-Agent: Mutt/1.5.11+cvs20060330
X-SA-Exim-Connect-IP: 84.189.224.114
Subject: Re: [-mm patch] drivers/media/video/bt866.c: small fixes
X-SA-Exim-Version: 4.2 (built Thu, 16 Feb 2006 12:49:04 +1100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2006, Martin Samuelsson wrote:
>  		current->state = TASK_INTERRUPTIBLE;
> -		schedule_timeout(HZ/10);
> +		schedule_timeout_interruptible(HZ/10);

schedule_timeout_interruptible() already sets current->state.

Johannes
