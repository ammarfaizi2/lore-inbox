Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269500AbUINRxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269500AbUINRxF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 13:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269461AbUINRt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 13:49:57 -0400
Received: from host50.200-117-131.telecom.net.ar ([200.117.131.50]:50075 "EHLO
	smtp.bensa.ar") by vger.kernel.org with ESMTP id S269495AbUINRoP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 13:44:15 -0400
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: Re: /proc/config reducing kernel image size
Date: Tue, 14 Sep 2004 14:44:02 -0300
User-Agent: KMail/1.7
Cc: Tom Fredrik Blenning Klaussen <bfg-kernel@blenning.no>
References: <1095179606.11939.22.camel@host-81-191-110-70.bluecom.no>
In-Reply-To: <1095179606.11939.22.camel@host-81-191-110-70.bluecom.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409141444.02624.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Fredrik Blenning Klaussen wrote:
> There is no point in storing all the comments and unused options in the

Try this:

    mv .config .config-saveme
    grep -v ^# .config-saveme  > .config
    make oldconfig

Do you get the exact same kernel (hint: diff .config .config-saveme) ?


Regards,
Norberto
