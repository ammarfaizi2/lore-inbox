Return-Path: <linux-kernel-owner+w=401wt.eu-S932849AbWLNQLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932849AbWLNQLc (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 11:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932848AbWLNQLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 11:11:31 -0500
Received: from il.qumranet.com ([62.219.232.206]:43393 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932844AbWLNQLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 11:11:31 -0500
Message-ID: <458177B0.2090804@argo.co.il>
Date: Thu, 14 Dec 2006 18:11:28 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>, thunder7@xs4all.nl,
       Arjan van de Ven <arjan@infradead.org>,
       Franck Pommereau <pommereau@univ-paris12.fr>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Clarify i386/Kconfig explanation of the HIGHMEM config
 options
References: <458118BB.5050308@univ-paris12.fr> <1166090244.27217.978.camel@laptopd505.fenrus.org> <45813E67.80709@univ-paris12.fr> <1166098747.27217.1018.camel@laptopd505.fenrus.org> <20061214151745.GC9079@thunk.org> <20061214152721.GA5652@amd64.of.nowhere> <20061214153754.GD9079@thunk.org>
In-Reply-To: <20061214153754.GD9079@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
>> +	  1 Gigabyte or more total physical RAM, answer "off" here.
>>
>>     
>
> I don't think your proposed wording (1 gigabyte or more) versus (more
> than 1 gigabyte) doesn't really change the sense of this.
>
> If we want to be even more explicit about this, then if the CPU level
> selected by the user is greater than Pentium-M (or whatever is was the
> oldest CPU that didn't have NX support --- Arjan?) we shouldn't offer
> this choice at all, and force CONFIG_HIGHMEM64G.  We can give the user
> a choice if CONFIG_EMBEDDED is enabled, but otherwise, if the CPU
> level is new enough, I think we can safely make the argument that for
> nearly all systems, they have enough memory and speed that perhaps we
> should just simply always use HIGHMEM64G.
>   

CONFIG_HIGHMEM64G is not a good name for PAE, which is a feature that 
enables both large physical memory and nx.

IMO we should have CONFIG_PAE, selected by either CONFIG_HIGHMEM64G or a 
new CONFIG_NO_EXEC.



-- 
error compiling committee.c: too many arguments to function

