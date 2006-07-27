Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161005AbWG0JAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161005AbWG0JAZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 05:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161022AbWG0JAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 05:00:25 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:52161 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161019AbWG0JAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 05:00:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iuI3dSTu7zN1/k7HkzyghZ2CZ7lf56/EvqzAvCDv0WSWYc71iEPnVWeNIeA4hQL0jjwDrm1iXbwqC2Hbf6ba9bSHPHnz0ENmFqycxIlMr+K49OuNYU7nLLZ8/k5jhqeNpaqnT1R0FMNbLSSgS2mWFfVh90RiOurQxPuL15UiZNI=
Message-ID: <b0943d9e0607270200h250953d7uf58dc9a4f087cb0b@mail.gmail.com>
Date: Thu, 27 Jul 2006 10:00:23 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Catherine Zhang" <cxzhang@watson.ibm.com>
Subject: Re: RFC: kernel memory leak fix for af_unix datagram getpeersec
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jmorris@namei.org,
       sds@tycho.nsa.gov, davem@davemloft.net, michal.k.k.piotrowski@gmail.com,
       czhang.us@gmail.com
In-Reply-To: <20060726201916.GA32505@jiayuguan.watson.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060726201916.GA32505@jiayuguan.watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/06, Catherine Zhang <cxzhang@watson.ibm.com> wrote:
> Enclosed please find the new fix for the memory leak problem, incorporating
> suggestions from Stephen and James.

FYI, Michal confirmed that, with this patch, kmemleak no longer
reports leaks in the context_struct_to_string() function in
security/selinux/ss/services.c. Many thanks to Michal for testing this
(and his constant feedback into kmemleak).

-- 
Catalin
