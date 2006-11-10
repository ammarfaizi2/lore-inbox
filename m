Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424416AbWKJUrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424416AbWKJUrK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 15:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424417AbWKJUrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 15:47:09 -0500
Received: from codepoet.org ([166.70.99.138]:23249 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S1424416AbWKJUrI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 15:47:08 -0500
Date: Fri, 10 Nov 2006 13:47:06 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFT] mv643xxx_eth_start_xmit oops
Message-ID: <20061110204706.GA14383@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org,
	Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
References: <20061110191745.GA13783@codepoet.org> <20061110115444.07f58e40@freekitty>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061110115444.07f58e40@freekitty>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Nov 10, 2006 at 11:54:44AM -0800, Stephen Hemminger wrote:
> The code int mv643xx_eth_start_xmit is not safe on SMP it was
> checking for space outside of lock.

Hmm.  I do not have CONFIG_SMP enabled...  But then I suppose the
function is not reentrant either, so networking from N apps would
eventually result in a collision where it would blow up.  That
seems consistant with what I was seeing.

> Does the following (untested) fix it?

Thanks!  It at least applies cleanly and compiles...
Will let you know if it seems fixed.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
