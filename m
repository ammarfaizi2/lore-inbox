Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964903AbVITHny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbVITHny (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 03:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbVITHny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 03:43:54 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:18740 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964903AbVITHny convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 03:43:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iUpHE8P3Pz3Qd8b2Y/TEShW3AnIHaACCG6AmS8xh2XFZevyB4bF/e3sYs7kGn/FXtKMQ+UV47EoVNkAZonzJ8slUGVjcSexhyqiWv13SW3Qn/Lyll6e0Jr+kmOjGXJ379n9Eh0lairXoY280AXlkZLMZ2vFpVRpEyCJJmJotKMk=
Message-ID: <3b8510d80509200043e09eae9@mail.gmail.com>
Date: Tue, 20 Sep 2005 13:13:51 +0530
From: Thayumanavar Sachithanantham <thayumk@gmail.com>
Reply-To: thayumk@gmail.com
To: Ustyugov Roman <dr_unique@ymg.ru>
Subject: Re: [BUG] module-init-tools
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3b8510d805092000346c27270f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509191432.58736.dr_unique@ymg.ru>
	 <3b8510d8050920000560aeb39e@mail.gmail.com>
	 <3b8510d805092000116c6a9c33@mail.gmail.com>
	 <200509201124.35942.dr_unique@ymg.ru>
	 <3b8510d8050920002661c08f48@mail.gmail.com>
	 <3b8510d805092000346c27270f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please change the lines that you have mentioned to this:
 
buf_printf(b, " .name = KBUILD_MODNAME,\n"); 
modname_flags = $(if $(filter 1,$(words $(modname))),-D'DUM(a)=\#a'
-D'KBUILD_MODNAME=DUM($(subst $(comma),_,$(subst -,_,$(modname))))')
 
Let me know your results.Take care of the quotes while you change.

Thayumanavar
