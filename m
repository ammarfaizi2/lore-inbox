Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751048AbWINTLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbWINTLe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 15:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbWINTLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 15:11:34 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:28288 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751048AbWINTLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 15:11:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Lnxeqo6xzP7ldZPGOF55zYYj16BIrvcASlu7S1xVo66RT++Q356phNHNm8Hgkkuekv6GaVsv80JToMqDAbYDDeqpGF4h0GugNuqZYxktrVpFVjuesQwmNb3LArXRmLx7xJDNYZM/foauySikGvhot1ra7ewjKlkQs0jc3G+y5ww=
Message-ID: <d120d5000609141211o76432bd3l82582ef3896e3be@mail.gmail.com>
Date: Thu, 14 Sep 2006 15:11:32 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: [PATCH 0/3] Synaptics - fix lockdep warnings
Cc: "Jiri Kosina" <jikos@jikos.cz>, lkml <linux-kernel@vger.kernel.org>,
       "Ingo Molnar" <mingo@elte.hu>
In-Reply-To: <1158260584.4200.3.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0609140227500.22181@twin.jikos.cz>
	 <Pine.LNX.4.64.0609141635040.2721@twin.jikos.cz>
	 <d120d5000609140758w7ba5cfdbs399d6831082e7cb4@mail.gmail.com>
	 <Pine.LNX.4.64.0609141700250.2721@twin.jikos.cz>
	 <d120d5000609140851r2299c64cv8b0a365be795a1bc@mail.gmail.com>
	 <Pine.LNX.4.64.0609141754480.2721@twin.jikos.cz>
	 <d120d5000609140918j18d68a4dmd9d9e1e72d2fd718@mail.gmail.com>
	 <Pine.LNX.4.64.0609142037110.2721@twin.jikos.cz>
	 <d120d5000609141156h5e06eb68k87a6fe072a701dab@mail.gmail.com>
	 <1158260584.4200.3.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/06, Arjan van de Ven <arjan@infradead.org> wrote:
>
> >
> > I think it is - as far as I understand the reason for not tracking
> > every lock individually is just that it is too expensive to do by
> > default.
>
> that is not correct. While it certainly plays a role,
> the other reason is that you can find out "class" level locking rules
> (such as inode->i_mutex comes before <other lock>) for all inodes at a
> time; eg no need to see every inode do this before you can find the
> deadlock.
>

OK, I can see that. However you must agree that for certain locks we
do want to track them individually, right?

-- 
Dmitry
