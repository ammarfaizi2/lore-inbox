Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbWJKNUB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbWJKNUB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 09:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWJKNUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 09:20:01 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:57749 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751277AbWJKNUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 09:20:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MJdPrBBSg7eV3FKsanylS9h9BIQhbW6UHUYkOR1tpDe3Kmv3325rOUupGgyqJu/0tZDbmcmOtCwXd/6thS1x1aRKXWo9eXX5oGmAh/Dqh9EJo71VcJg6Xqzoj+R/JED5PJof7GpJvldAmJMSLylenF8S2of+FAJUpyfKA0BUxmA=
Message-ID: <41840b750610110619v56d3efd5h7a05cfb42cb21464@mail.gmail.com>
Date: Wed, 11 Oct 2006 15:19:58 +0200
From: "Shem Multinymous" <multinymous@gmail.com>
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       hdaps-devel@sourceforge.net
Subject: Re: Debugging strange system lockups possibly triggered by ATA commands
In-Reply-To: <87ejtgatgp.fsf@denkblock.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <741Eo-2m9-5@gated-at.bofh.it> <742hc-4n3-25@gated-at.bofh.it>
	 <87ejtgatgp.fsf@denkblock.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elias,

On 10/10/06, Elias Oltmanns <oltmanns@uni-bonn.de> wrote:
> Testing the queue handling stuff without actually issuing any
> commands seems rather difficult to me as its the callback mechanism
> used to freeze the queue after command completion which I'd really
> like to test. If I don't issue any command, I don't know how to test
> whether the callback procedure and all the rest works as expected.

Try doing a dump_stack(), and nothing else, in the callback. This may
provide some hint.

(Remember to increase console_loglevel so you can see the result on
the console before the hang.)

  Shem
