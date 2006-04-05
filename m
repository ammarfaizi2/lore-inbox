Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbWDERAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWDERAY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 13:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWDERAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 13:00:24 -0400
Received: from pproxy.gmail.com ([64.233.166.180]:26298 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751278AbWDERAY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 13:00:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NLVRg0PkaoBKQ9N4eIvKbMiwVuJizPm/BNY1CVvnZBcDYktU2oaZHrFKaiS1NHKXZHYAQFDJNuF4JHqWtMFiAmZfSIUKr15tOx6EqgQWeVVYH0daWUYsHD/un25aieZMn9lVa3U3sJWMrvcuFUvCMm5iKIOFx7NFJ+qfN5oyKo0=
Message-ID: <bda6d13a0604051000l6b804576wd211ac98d59756d8@mail.gmail.com>
Date: Wed, 5 Apr 2006 10:00:23 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_FRAME_POINTER and module vermagic
In-Reply-To: <Pine.LNX.4.61.0604050729210.4636@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <442ACAD6.6@nortel.com>
	 <Pine.LNX.4.61.0603291308240.28274@chaos.analogic.com>
	 <4432EC08.4010104@nortel.com>
	 <Pine.LNX.4.61.0604050729210.4636@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> you refer, points to. The structure member, ebp, contains the
> value of the EBP register when the kernel was called. Since EBP
> was the first register saved in the array, it is likely (didn't check)
> that the location referenced by "regs->ebp + 4" was, in fact, the
> return address. In any event, the value of regs->ebp is simply
> the value in a structure member, not the value of any current
> registers.
Confirmed. This is the standard stack frame, and all debuggers assume this.
