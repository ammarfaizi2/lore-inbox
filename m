Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbVF0TOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbVF0TOV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 15:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbVF0TL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 15:11:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29088 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261614AbVF0THf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 15:07:35 -0400
Date: Mon, 27 Jun 2005 15:07:29 -0400
From: Dave Jones <davej@redhat.com>
To: Michael Krufky <mkrufky@m1k.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fix silly config option.
Message-ID: <20050627190728.GA11186@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Michael Krufky <mkrufky@m1k.net>, linux-kernel@vger.kernel.org
References: <20050627053928.GA9759@redhat.com> <42C04D82.9000108@m1k.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C04D82.9000108@m1k.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 03:03:30PM -0400, Michael Krufky wrote:

 > +config CONFIG_TUNER_MULTI_I2C
 > +#define CONFIG_TUNER_MULTI_I2C /**/
 > +#ifdef CONFIG_TUNER_MULTI_I2C
 > +#ifdef CONFIG_TUNER_MULTI_I2C
 > +#ifdef CONFIG_TUNER_MULTI_I2C
 > +#ifndef CONFIG_TUNER_MULTI_I2C
 > +#ifdef CONFIG_TUNER_MULTI_I2C
 > 
 > ... So in fact, after applying your patch above,  NOW it is a silly 
 > config option, which in effect, removed all functionality of 
 > CONFIG_TUNER_MULTI_I2C alltogether

Err, no. Note how no other config options have CONFIG_ prepended
to them. Kconfig magic does this for you implicitly.

		Dave

 
