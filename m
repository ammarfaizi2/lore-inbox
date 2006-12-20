Return-Path: <linux-kernel-owner+w=401wt.eu-S964996AbWLTLRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbWLTLRk (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 06:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964998AbWLTLRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 06:17:40 -0500
Received: from wx-out-0506.google.com ([66.249.82.225]:19060 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964996AbWLTLRj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 06:17:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZMkExjHaFUE2GoxQnNiM5cOzFvgZKRX8HFQxL49/DGF7ZrQkYRGwQIWTnEMOtGLL7DYs2AiJSqL9B6X1nhq77wtiCi2Men0kdLfC4E5GuXr7GUKEWRkNT9u78ClGs+2EIuX7Gl63Iu9moFFZJyZRv8ig6LKfWMBcEcaUISAdedQ=
Message-ID: <652016d30612200317i6d33d097xe55971750e83cd97@mail.gmail.com>
Date: Wed, 20 Dec 2006 17:02:38 +0545
From: "Manish Regmi" <regmi.manish@gmail.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: Re: Linux disk performance.
Cc: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
In-Reply-To: <458788D7.2070107@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <652016d30612172007m58d7a828q378863121ebdc535@mail.gmail.com>
	 <1166431020.3365.931.camel@laptopd505.fenrus.org>
	 <652016d30612180439y6cd12089l115e4ef6ce2e59fe@mail.gmail.com>
	 <20061218130702.GA14984@gateway.home>
	 <652016d30612182222h7fde4ea5jbc0927c8ebeae76a@mail.gmail.com>
	 <458788D7.2070107@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/06, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> When you submit a request to an empty block device queue, it can
> get "plugged" for a number of timer ticks before any IO is actually
> started. This is done for efficiency reasons and is independent of
> the IO scheduler used.
>

Thanks for the information..

> Use the noop IO scheduler, as well as the attached patch, and let's
> see what your numbers look like.
>

Unfortunately i got the same results even after applying your patch. I
also tried putting
q->unplug_delay = 1;
But it did not work. The result was similar.

-- 
---------------------------------------------------------------
regards
Manish Regmi

---------------------------------------------------------------
UNIX without a C Compiler is like eating Spaghetti with your mouth
sewn shut. It just doesn't make sense.
