Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422948AbWHZAdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422948AbWHZAdP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 20:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422957AbWHZAdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 20:33:15 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:61869 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422948AbWHZAdO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 20:33:14 -0400
Message-ID: <44EF96C4.6020505@us.ibm.com>
Date: Fri, 25 Aug 2006 17:33:08 -0700
From: Kylene Hall <kjhall@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Kyle <david.kyle@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: TPM module: lack of internal kernel interface
References: <361d23520608251411g256804d8t678a98e0ff552454@mail.gmail.com>
In-Reply-To: <361d23520608251411g256804d8t678a98e0ff552454@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David-

I wouldn't have a problem with this.  In fact all that should be 
necessary is to export the tpm_transmit function and maybe a way to get 
the tpm_chip struct for the particular tpm you want since the driver is 
setup to handle multiple tpms.  We have played around with only 
exporting functions that were necessary (such as tpm_extend for work we 
have done but if there is a usecase for that it should work.

Thanks,
Kylie

David Kyle wrote:
> I'm currently working on implementing a trusted computing system using
> the linux TPM driver, similar to enforcer
> (http://enforcer.sourceforge.net).  As my project involves kernel
> modifications that are highly unlikely to be of use within the
> mainstream kernel, I am attempting to confine my kernel-level work to
> a linux security module, so that my system will hopefully not be
> affected too heavily by newer kernel versions.
> 
> Hovever, I have run into difficulty since the TPM driver included in
> the kernel doesn't include a internal interface for TPM access from
> within the kernel itself.  There is only a userspace character device
> interface.  Is there in fact an internal TPM interface I'm not seeing?
> If not, is there a particular reason why there isn't (and shouldn't
> be) one?
> 
> It seems to me that it would be important to have such an interface
> for any trusted computing system.  Enforcer uses it's own tpm kernel
> driver, which I'd definately like to avoid doing with my project.
> 
> If I were to extend the existing TPM driver with an internal kernel
> interface, would it likely be included in the mainstream kernel?
> 
> Thanks,
> David Kyle
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

