Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbWBZTa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWBZTa4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 14:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWBZTa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 14:30:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54668 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932231AbWBZTa4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 14:30:56 -0500
Date: Sun, 26 Feb 2006 14:30:40 -0500
From: Dave Jones <davej@redhat.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Building 100 kernels; we suck at dependencies and drown in warnings
Message-ID: <20060226193040.GF7851@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
References: <200602261721.17373.jesper.juhl@gmail.com> <9a8748490602260831l3338f03ew60f99648848aa177@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490602260831l3338f03ew60f99648848aa177@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2006 at 05:31:49PM +0100, Jesper Juhl wrote:
 > drivers/char/agp/amd64-agp.c:754: warning: unused variable `amd64nb'

This is due to CONFIG_PCI not being set, which doesn't really
make any sense on x86-64, as there aren't any PCI-less systems
on that platform (With the CPU containing a PCI northbridge, it
doesn't make a lot of sense not to have PCI enabled)

		Dave

