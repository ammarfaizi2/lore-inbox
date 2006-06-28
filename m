Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932843AbWF1PnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932843AbWF1PnV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 11:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932846AbWF1PnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 11:43:21 -0400
Received: from are.twiddle.net ([64.81.246.98]:44737 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S932843AbWF1PnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 11:43:21 -0400
Date: Wed, 28 Jun 2006 08:43:20 -0700
From: Richard Henderson <rth@twiddle.net>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: Re: [klibc 04/31] alpha support for klibc
Message-ID: <20060628154320.GA18511@twiddle.net>
Mail-Followup-To: "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org, klibc@zytor.com
References: <klibc.200606272217.00@tazenda.hos.anvin.org> <klibc.200606272217.04@tazenda.hos.anvin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <klibc.200606272217.04@tazenda.hos.anvin.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 10:17:04PM -0700, H. Peter Anvin wrote:
> +# Special CFLAGS for the divide code
> +DIVCFLAGS = $(KLIBCREQFLAGS) $(KLIBCARCHREQFLAGS) \
> +	-O3 -fomit-frame-pointer -fcall-saved-1 -fcall-saved-2 \
> +	-fcall-saved-3 -fcall-saved-4 -fcall-saved-5 -fcall-saved-6 \
> +	-fcall-saved-7 -fcall-saved-8 -ffixed-15 -fcall-saved-16 \
> +	-fcall-saved-17 -fcall-saved-18 -fcall-saved-19 -fcall-saved-20 \
> +	-fcall-saved-21 -fcall-saved-22 -ffixed-23 -fcall-saved-24 \
> +	-ffixed-25 -ffixed-27

These routines absolutely cannot be written in C.  The return value
goes in a different register, which you cannot modify via compiler
flags.  Please use the hand-coded assembly from linux/arch/alpha/lib/.


r~
