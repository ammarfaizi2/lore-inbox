Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269106AbUJFHr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269106AbUJFHr0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 03:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269100AbUJFHrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 03:47:25 -0400
Received: from quechua.inka.de ([193.197.184.2]:63976 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S269093AbUJFHrS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 03:47:18 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.9-rc3-mm2] [m32r] SIO driver for m32r
Organization: Deban GNU/Linux Homesite
In-Reply-To: <20041006.151912.840807084.takata.hirokazu@renesas.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1CF6W4-0001hS-00@calista.eckenfels.6bone.ka-ip.net>
Date: Wed, 06 Oct 2004 09:47:16 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20041006.151912.840807084.takata.hirokazu@renesas.com> you wrote:
> +static void sio_error(int *status)
> +{
> +       printk("SIO0 error[%04x]\n", *status);
> +       do {
> +               sio_init();
> +       } while ((*status = __sio_in(PLD_ESIO0CR)) != 3);
> +}

is this safe and sane? Wont that lockup the machine on hardware problems? It
is also duplicated, with only the port differ.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
