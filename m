Return-Path: <linux-kernel-owner+w=401wt.eu-S965080AbXASMEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965080AbXASMEt (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 07:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965081AbXASMEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 07:04:49 -0500
Received: from wr-out-0506.google.com ([64.233.184.235]:51002 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965080AbXASMEs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 07:04:48 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=ILH0pYVir9jsDwy+ICCq4rTPk2XRqemSQNm3iCFUxt6y8D/Blz8AjpmxjD5He4BO3ny8qw5HaoAxw14H6OveN7v7nPAt4P2BeDgxzfzN4+cBCwSI9wWat8qLHrbV3s3DNiUaxnlF2OzBmuBqgkx+AMWwb3ZptW6/IkYAAFhspBw=
Message-ID: <84144f020701190404u5162db92mcea13a709d487602@mail.gmail.com>
Date: Fri, 19 Jan 2007 14:04:47 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Michael Halcrow" <mhalcrow@us.ibm.com>
Subject: Re: [PATCH 2/5] eCryptfs: convert kmap() to kmap_atomic()
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20070118212725.GD3643@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070118212627.GC3643@us.ibm.com>
	 <20070118212725.GD3643@us.ibm.com>
X-Google-Sender-Auth: 2ce8a52d4e975d02
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/07, Michael Halcrow <mhalcrow@us.ibm.com> wrote:
> +       page_data = (char *)kmap_atomic(page, KM_USER0);
> +       lower_page_data = (char *)kmap_atomic(lower_page, KM_USER1);

Drop 'em redundant casts, please.
