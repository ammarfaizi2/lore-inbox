Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbWBFFYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWBFFYg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 00:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbWBFFYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 00:24:36 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:44758 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750986AbWBFFYf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 00:24:35 -0500
Subject: Re: [RFC PATCH] crc generation fix for EXPORT_SYMBOL_GPL
From: Ram Pai <linuxram@us.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1139085087.3131.8.camel@laptopd505.fenrus.org>
References: <20060202041543.GA6755@RAM>
	 <1139085087.3131.8.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: IBM 
Date: Sun, 05 Feb 2006 21:24:31 -0800
Message-Id: <1139203471.4641.41.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-02-04 at 21:31 +0100, Arjan van de Ven wrote:
> On Wed, 2006-02-01 at 20:15 -0800, Ram Pai wrote:
> > Currently genksym does not take into account the GPLness of the exported
> > symbol while generating the crc for the exported symbol. Any symbol
> > changes from EXPORT_SYMBOL to EXPORT_SYMBOL_GPL would not reflect in the
> > Module.symvers file.  This patch fixes that problem.
> 
> and this is a problem.. why?

Tools that depend on Module.symvers wont be able to detect the change in
GPLness of the exported symbols.

Eventually we want to generate a tool that can report API changes across
kernel releases and put it in some friendly(docbook) format.

Suggestions?
RP


> 
> 

