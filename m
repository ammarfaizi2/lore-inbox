Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030655AbVIBC31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030655AbVIBC31 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 22:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030657AbVIBC31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 22:29:27 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:12168 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030655AbVIBC30 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 22:29:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AXn/FRqBm1r/ErMsN9bS+dWh2syQvMqH6IHLosyWZPwm7qtT53kLcfgjVxJlq0c3UHMSDOgCMH+XgzBnDgRJdcEv9ARwXBpji9dI6w9/26mFi1qs0LYlbCk9vp3RQ3jf1juavmM/uAA4eVNfbaZ+A/IU+0HOGNqby4nZzXJsNbc=
Message-ID: <67029b17050901192933f9618@mail.gmail.com>
Date: Fri, 2 Sep 2005 10:29:12 +0800
From: Zhou Yingchao <yingchao.zhou@gmail.com>
Reply-To: yingchao.zhou@gmail.com
To: "liyu@WAN" <liyu@ccoss.com.cn>
Subject: Re: [Q] how to use syslogd to debug kernel ?
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <4317B309.3000404@ccoss.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4317B309.3000404@ccoss.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/05, liyu@WAN <liyu@ccoss.com.cn> wrote:
> Hi, everyone.
> 
>    I know kernel oops can be seen by run 'dmesg', but if
> kernel crashed, we can not run it.   so I reconfigure syslogd
> to support remote forward, the debug machine content of
> syslogd.conf is:

When the panic is called, the network system cannt working, no
message will be sent. The panic is only designed to print at least
 oops message on the screen. 
For debug through ethernet, I suggest you to try KGDB, which consist
a patch to debug over ethernet. 

-- 
Yingchao Zhou
