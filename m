Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266318AbTA0NyA>; Mon, 27 Jan 2003 08:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266952AbTA0NyA>; Mon, 27 Jan 2003 08:54:00 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:59716 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S266318AbTA0Nx7>;
	Mon, 27 Jan 2003 08:53:59 -0500
Date: Mon, 27 Jan 2003 15:03:13 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: "Ph. Marek" <philipp.marek@bmlv.gv.at>
Cc: aeb@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/partitions/msdos.c Guard against negative sizes
Message-ID: <20030127140313.GA3156@win.tue.nl>
References: <200301271230.05814.philipp.marek@bmlv.gv.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301271230.05814.philipp.marek@bmlv.gv.at>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ach, I didnt pay attention, had not seen that this was cc-ed to l-k;
let me repeat on l-k]

On Mon, Jan 27, 2003 at 12:30:05PM +0100, Ph. Marek wrote:

>                 u32 size = NR_SECTS(p)*sector_size;
> -               if (!size)
> +               if (size <= 0)

This doesnt work since size is unsigned.

Andries
