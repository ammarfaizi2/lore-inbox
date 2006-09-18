Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965212AbWIRNyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965212AbWIRNyW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 09:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965219AbWIRNyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 09:54:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:7062 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965213AbWIRNyV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 09:54:21 -0400
From: Andi Kleen <ak@suse.de>
To: "Stuart MacDonald" <stuartm@connecttech.com>
Subject: Re: TCP stack behaviour question
Date: Mon, 18 Sep 2006 15:54:15 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <000001c6db25$3f778c30$294b82ce@stuartm>
In-Reply-To: <000001c6db25$3f778c30$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609181554.15820.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> # man 7 ip
> ..
>                Note that TCP has no error queue; MSG_ERRQUEUE is
> illegal on SOCK_STREAM sockets.  Thus all errors are returned by
> socket function return or SO_ERROR only.
> 
> Maybe the man page is wrong? That's from my FC 3 install.

The sentence is correct, but TCP has a IP_RECVERR that works
differently without a queue. Basically it doesn't delay the error 
reporting for incoming ICMPs to the last retransmit, but reports
them immediately. This is documented in tcp(7)

-Andi
