Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263756AbUDFKwY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 06:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263747AbUDFKwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 06:52:23 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:13483 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263751AbUDFKwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 06:52:22 -0400
Date: Tue, 6 Apr 2004 11:49:30 +0100
From: Dave Jones <davej@redhat.com>
To: "Angelo Dell'Aera" <buffer@antifork.org>
Cc: Jan Killius <jkillius@arcor.de>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Oops with cpufreq on 2.6.5-mm1
Message-ID: <20040406104930.GA32405@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Angelo Dell'Aera <buffer@antifork.org>,
	Jan Killius <jkillius@arcor.de>,
	Linux-Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <20040406000500.GA26760@gate.unimatrix> <20040406115149.6fc6edf8.buffer@antifork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040406115149.6fc6edf8.buffer@antifork.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 11:51:49AM +0200, Angelo Dell'Aera wrote:
 > On Tue, 6 Apr 2004 02:05:00 +0200
 > Jan Killius <jkillius@arcor.de> wrote:
 > 
 > >Hi,
 > >cpufreq make an Oops on loading. I have attached the oops.
 > 
 > The problem seems to be located in find_psb_table(). In fact, 
 > while powernow_table is correctly initialized, it's never assigned
 > to data->powernow_table thus leading to a NULL pointer dereferencing
 > in cpufreq_frequency_table_cpuinfo(). Try this patch please.

-mm has an incomplete merge of the large set of changes in this
driver. I'm working on it, and should get the merge complete today.

		Dave

