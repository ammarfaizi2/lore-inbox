Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbWF0KDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbWF0KDe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 06:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbWF0KDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 06:03:33 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:25810 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1751087AbWF0KDd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 06:03:33 -0400
Date: Tue, 27 Jun 2006 00:03:45 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: Re: [klibc 28/43] mips support for klibc
Message-ID: <20060626230345.GA14345@linux-mips.org>
References: <klibc.200606251757.28@tazenda.hos.anvin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <klibc.200606251757.28@tazenda.hos.anvin.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2006 at 05:58:05PM -0700, H. Peter Anvin wrote:

> +typedef struct flock {
> +	short	l_type;
> +	short	l_whence;
> +	loff_t	l_start;
> +	loff_t	l_len;
> +	pid_t	l_pid;
> +} flock_t;

32-bit MIPS uses this:

struct flock {
        short   l_type;
        short   l_whence;
        off_t   l_start;
        off_t   l_len;
        long    l_sysid;
        __kernel_pid_t l_pid;
        long    pad[4];
};
