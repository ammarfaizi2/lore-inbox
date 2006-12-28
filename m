Return-Path: <linux-kernel-owner+w=401wt.eu-S964908AbWL1DxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964908AbWL1DxP (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 22:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbWL1DxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 22:53:15 -0500
Received: from an-out-0708.google.com ([209.85.132.240]:36457 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964910AbWL1DxO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 22:53:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jLeWzz4WooFzbLLqzdv7KEDoQdVz8Hf9rTdYJyoNy7brgVoVuKn+aM+FP2UuPUhsfnsYHaFD8CcodaHO3D72tYavHSRcwan6lepN6s2NSbtdOIGyGYD/C0Ti5W/4n2FmDBZef3QHofDr9+U6xP6YgyExxH0ASvnY9IVX74W4xzg=
Message-ID: <45a44e480612271953we6fe8adg118560161579b7f9@mail.gmail.com>
Date: Thu, 28 Dec 2006 04:53:13 +0100
From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
To: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
Subject: Re: [RFC 2.6.19 1/1] fbdev,mm: hecuba/E-Ink fbdev driver v2
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
In-Reply-To: <cda58cb80612220157q5433c346pccd06b8b7cbaadba@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200612111046.kBBAkV8Y029087@localhost.localdomain>
	 <457D895D.4010500@innova-card.com>
	 <45a44e480612111554j1450f35ub4d9932e5cd32d4@mail.gmail.com>
	 <cda58cb80612130038x6b81a00dv813d10726d495eda@mail.gmail.com>
	 <45a44e480612162025n5d7c77bdkc825e94f1fb37904@mail.gmail.com>
	 <cda58cb80612200050h6def9866nf1798753da9d842d@mail.gmail.com>
	 <cda58cb80612220157q5433c346pccd06b8b7cbaadba@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/06, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>
> Well thinking more about it, this wouldn't work for all cache types.
> For example, if your cache is not a direct maped one, this workaround
> won't work. So this is definitely not a portable solution.
>

>From asking peterz on #mm, I think page_mkclean will do the right
thing and call something like flush_cache_page. I think that resolves
the issue which I think you identified where the end symptom on archs
with virtually tagged caches could be a line of pixels written by
userspace through one PTE remain in-cache and therefore "undisplayed"
when the kernel reads through another PTE that may fall on a different
cacheline.

Thanks,
jayakumar
