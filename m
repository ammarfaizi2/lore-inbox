Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262363AbVDGBdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbVDGBdE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 21:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbVDGBdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 21:33:03 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:33214 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262363AbVDGBcy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 21:32:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=F5/d3y+bIOvR5FunryBk8i7T+nKj+Re195klQ90ci6tgJep6WWcIwND/wNA9KRmvKawHG7aG62UyWy9Pm4X6xZnBXSsSdnmuxvlfiivHxqBqJMwuf1pC/Jqc0X45XFDJff82YiKunUEfXlOfnH5ULgmr+ORaL3r7/GRyEq4CTQo=
Message-ID: <54b5dbf505040618324186678a@mail.gmail.com>
Date: Thu, 7 Apr 2005 07:02:53 +0530
From: AsterixTheGaul <asterixthegaul@gmail.com>
Reply-To: AsterixTheGaul <asterixthegaul@gmail.com>
To: Magnus Damm <damm@opensource.se>
Subject: Re: [PATCH][RFC] disable built-in modules V2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050405225747.15125.8087.59570@clementine.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050405225747.15125.8087.59570@clementine.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -#define module_init(x) __initcall(x);
> +#define module_init(x) __initcall(x); __module_init_disable(x);

It would be better if there is brackets around them... like

#define module_init(x) { __initcall(x); __module_init_disable(x); }

then we know it wont break some code like

if (..)
 module_init(x);

thanks.
