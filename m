Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbVCHP6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVCHP6z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 10:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVCHP6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 10:58:55 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:26724 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261338AbVCHP6x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 10:58:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=AIPXJjuUJXR9bK7LThjAPfHT+Xvn3OXcZA3cNm/pyHX3r3n2J5MLL9rDaiEPq8Y+z1IdG2CSk7fq9oWPmGm50GiQyF8g2S9I4KV2FAsPuVSpETWrXzwHBsX+4PVYzirULqvlLss+Qrr1O7srwYOABmM66tnSqRT5RIv2glIh83E=
Message-ID: <d120d500050308075839d7400c@mail.gmail.com>
Date: Tue, 8 Mar 2005 10:58:49 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Henk Vergonet <rememberme@god.dyndns.org>
Subject: Re: RFC: Harmonised parameter passing
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050308154747.GA10071@god.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050308145923.GA9914@god.dyndns.org>
	 <d120d5000503080714ba3843d@mail.gmail.com>
	 <20050308154747.GA10071@god.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2005 16:47:47 +0100, Henk Vergonet
<rememberme@god.dyndns.org> wrote:
> One question remains though, how do you handle the initialization of
> multiple instances of an inbound driver?
> 
> mcd0.io=0x340 mcd1.io=0x350
> 

I think the most common practice is to specify a list of addresses:
mcd.io=0x340,0x350

module_param_array() helps here.

-- 
Dmitry
