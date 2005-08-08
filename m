Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbVHHRrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbVHHRrX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 13:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbVHHRrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 13:47:23 -0400
Received: from florence.buici.com ([206.124.142.26]:49877 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S932155AbVHHRrW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 13:47:22 -0400
Date: Mon, 8 Aug 2005 10:47:21 -0700
From: Marc Singer <elf@buici.com>
To: Marcel Holtmann <marcel@holtmann.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi
Message-ID: <20050808174721.GA2853@buici.com>
References: <1121025679.3008.10.camel@spirit> <1123492338.4762.96.camel@diimka.dev.rtsoft.ru> <20050808145544.GB6478@kroah.com> <1123522536.7751.51.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123522536.7751.51.camel@pegasus>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2005 at 07:35:36PM +0200, Marcel Holtmann wrote:
> > > +	if (NULL == dev || NULL == driver) {
> > 
> > Put the variable on the left side, gcc will complain if you incorrectly
> > put a "=" instead of a "==" here, which is all that you are defending
> > against with this style.
> 
> I think in this case the preferred way is
> 
> 	if (!dev || !driver) {
> 

That's not a guaranteed equivalence in the C standard.  Null pointers
may not be zero.  I don't think we have any targets that work this
way, however there is nothing wrong with explicitly testing for NULL.
