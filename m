Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932880AbWFMEog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932880AbWFMEog (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 00:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932879AbWFMEog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 00:44:36 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:36813 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932876AbWFMEof (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 00:44:35 -0400
Message-ID: <448E42AE.1010901@us.ibm.com>
Date: Mon, 12 Jun 2006 21:44:30 -0700
From: Sridhar Samudrala <sri@us.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH 2/2] update sunrpc to use in-kernel sockets API
References: <1150156564.19929.33.camel@w-sridhar2.beaverton.ibm.com> <Pine.LNX.4.64.0606122320010.31627@d.namei>
In-Reply-To: <Pine.LNX.4.64.0606122320010.31627@d.namei>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris wrote:
> On Mon, 12 Jun 2006, Sridhar Samudrala wrote:
>
>   
>> -	sendpage = sock->ops->sendpage ? : sock_no_sendpage;
>> +	sendpage = kernel_sendpage ? : sock_no_sendpage;
>>     
>
> This is not equivalent.
>
>   
Actually, we could make this a simple assignment as we check for 
sock->ops->sendpage in
kernel_sendpage().
    sendpage = kernel_sendpage;

Thanks
Sridhar

