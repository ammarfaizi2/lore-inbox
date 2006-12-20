Return-Path: <linux-kernel-owner+w=401wt.eu-S1161004AbWLTXAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161004AbWLTXAm (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 18:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161003AbWLTXAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 18:00:42 -0500
Received: from stargate.chelsio.com ([12.22.49.110]:6193 "EHLO
	stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161001AbWLTXAl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 18:00:41 -0500
Message-ID: <4589C088.7020107@chelsio.com>
Date: Wed, 20 Dec 2006 15:00:24 -0800
From: Divy Le Ray <divy@chelsio.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: jeff@garzik.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       swise@opengridcomputing.com
Subject: Re: [PATCH 4/10] cxgb3 - HW access routines - part 2
References: <200612201242.kBKCgaVU006331@localhost.localdomain> <1166623459.3365.1399.camel@laptopd505.fenrus.org>
In-Reply-To: <1166623459.3365.1399.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Dec 2006 23:00:24.0484 (UTC) FILETIME=[A1F84E40:01C7248A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>> +void t3_port_intr_disable(struct adapter *adapter, int idx)
>> +{
>> +	struct cphy *phy = &adap2pinfo(adapter, idx)->phy;
>> +
>> +	t3_write_reg(adapter, XGM_REG(A_XGM_INT_ENABLE, idx), 0);
>> +	phy->ops->intr_disable(phy);
>>     
>
> you seem to be missing a pci posting flush here....
>   
Thanks for catching this. Will fix.
