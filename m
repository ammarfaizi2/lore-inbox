Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbVJLMHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbVJLMHR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 08:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbVJLMHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 08:07:16 -0400
Received: from [195.23.16.24] ([195.23.16.24]:13238 "EHLO
	linuxbipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S932377AbVJLMHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 08:07:15 -0400
Message-ID: <434CFC6B.6090605@grupopie.com>
Date: Wed, 12 Oct 2005 13:07:07 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roberto Jung Drebes <drebes@inf.ufrgs.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: Instantiating my own random number generator
References: <E90C20D8-AC5D-4E9E-A477-48164FA0E7EE@inf.ufrgs.br>
In-Reply-To: <E90C20D8-AC5D-4E9E-A477-48164FA0E7EE@inf.ufrgs.br>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roberto Jung Drebes wrote:
> 
> Hi there,

Hi,

> I have a kernel module which asks for random numbers using  
> get_random_bytes().
> 
> Is there a way I can set this number generator my own seed value, so  
> that I can replay experiments I perform with my module? If I set a  seed 
> for the whole system, it would affect other kernel tasks  obtaining 
> random numbers through get_random_bytes(), so I guess that  is not a 
> good solution.

Why don't you implement a simple PRNG in your own module that you can 
control yourself for your experiments, and then replace it later with 
get_random_bytes()?

There are a number of PRNG's that are simple to implement and good 
enough for most problems:

http://en.wikipedia.org/wiki/List_of_pseudorandom_number_generators

I hope this helps,

-- 
Paulo Marques - www.grupopie.com

The rule is perfect: in all matters of opinion our
adversaries are insane.
Mark Twain
