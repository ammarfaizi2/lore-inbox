Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262483AbVAUT5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262483AbVAUT5u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 14:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262479AbVAUT5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 14:57:49 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:5612 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262483AbVAUT5k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 14:57:40 -0500
Date: Fri, 21 Jan 2005 20:57:29 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: James Simmons <jsimmons@pentafluge.infradead.org>
cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] merge vt_struct into vc_data
In-Reply-To: <Pine.LNX.4.56.0501211753550.26614@pentafluge.infradead.org>
Message-ID: <Pine.LNX.4.61.0501212053440.30794@scrub.home>
References: <20041231143457.GA9165@lst.de> <Pine.LNX.4.61.0501150440400.6118@scrub.home>
 <Pine.LNX.4.56.0501211753550.26614@pentafluge.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 21 Jan 2005, James Simmons wrote:

> Please don't remove strutc vt_struct. What should be done is that struct 
> vt_struct is used to hold the data that is shared amoung all the VCs. For 
> example struct consw. See we end up with something like this.
> 
> struct vt_struct {
> 	const struct consw *vt_sw;
> 	struct vc_data *vc_cons[MAX_NR_USER_CONSOLES];
> }

This is basically a completely different structure, which you can still 
reintroduce once needed (hopefully with a better name).

bye, Roman
