Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265744AbTFNUjo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 16:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265710AbTFNUjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 16:39:04 -0400
Received: from Mail1.kontent.de ([81.88.34.36]:36830 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261819AbTFNUiv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 16:38:51 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [patch] input: Add PCI PS/2 controller support [5/13]
Date: Sat, 14 Jun 2003 22:51:51 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <20030614223513.A25948@ucw.cz> <20030614223934.C25997@ucw.cz> <20030614224022.D25997@ucw.cz>
In-Reply-To: <20030614224022.D25997@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306142251.51235.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +static int pcips2_write(struct serio *io, unsigned char val)
> +{
> +	struct pcips2_data *ps2if = io->driver;
> +	unsigned int stat;
> +
> +	do {
> +		stat = inb(ps2if->base + PS2_STATUS);
> +		cpu_relax();
> +	} while (!(stat & PS2_STAT_TXEMPTY));

What will happen if somebody unplugs the base station while this
is running?

	Regards
		Oliver

