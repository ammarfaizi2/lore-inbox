Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423688AbWJaRIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423688AbWJaRIU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 12:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423692AbWJaRIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 12:08:20 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:936 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1423688AbWJaRIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 12:08:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=Qeh10aPt2KF4kkSZNJavpq0gE99b5/8z5NrQrPzSqNsH12K7F8DAnk5qGAgho/3BBe0I1azRL1Ls3LN7GRMyTd8x1r/jiKgx4DxOzCMsiUBvBomBmjm0WhMelzsI+S94bS2af40NMnpjMqo+GZiwF/ZvBQDXYrc7ig0iqftO40k=
Message-ID: <4547831B.8070704@innova-card.com>
Date: Tue, 31 Oct 2006 18:08:43 +0100
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Guillermo Marcus <marcus@ti.uni-mannheim.de>, linux-kernel@vger.kernel.org
Subject: Re: mmaping a kernel buffer to user space
References: <4547150F.8070408@ti.uni-mannheim.de> <4547733B.9040801@gmail.com> <45477912.7070903@ti.uni-mannheim.de> <45477EA8.8060809@gmail.com>
In-Reply-To: <45477EA8.8060809@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Jiri Slaby wrote:
> Guillermo Marcus wrote:
>> Hi Jiri,
>>
>> The fact that it does not works with RAM is well documented in LDD3,
>> pages 430++. It says (and I tested) that remap_xxx_range does not work
>> in this case. They suggest a method using nopage, similar to the one I
>> implement.
> 
> Could somebody confirm, that this still holds?

Apparently this restriction has been removed since 2.6.15 when
VM_PFNMAP flag has been introduced, see commit
6aab341e0a28aff100a09831c5300a2994b8b986

Why there's such restriction before 2.6.15, I haven't searched
yet, but any hints would be appreciated.

Thanks
		Franck
