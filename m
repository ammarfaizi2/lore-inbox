Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbUBNDoM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 22:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264604AbUBNDoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 22:44:12 -0500
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:43367 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261733AbUBNDoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 22:44:09 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: PATCH, RFC: Version 3 of 2.6 Codingstyle
Date: Fri, 13 Feb 2004 22:44:04 -0500
User-Agent: KMail/1.6
Cc: Michael Frank <mhf@linuxmail.org>
References: <200402130615.10608.mhf@linuxmail.org> <200402140944.34060.mhf@linuxmail.org>
In-Reply-To: <200402140944.34060.mhf@linuxmail.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402132244.04843.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 February 2004 08:44 pm, Michael Frank wrote:
>  
> -4) forgetting about sideeffects. Macros defining expressions must enclose the
> -expression in parenthesis. Note that this does not eliminate all side effects.
> +4) forgetting about side effects: macros defining expressions must enclose each
> +parameter and the expression in parentheses.
>  
>  #define CONSTEXP (CONSTANT | 3)
>  #define MACWEXP(a,b) ((a) + (b))
>

The statements above are incorrect.

Parentheses will never eliminate a side effect, macros do not have a
"side effect problem". Functions and macros both can have side effects
and sometimes side effect is a desired outcome.

Parentheses will only prevent surprises when argument expansion takes
place:

#define times_2(a)	(a * 2)
b = macro(a + 2);

will be expanded to:

b = (a + 2 * 2);

which is obviously not what programmer had in mind.

-- 
Dmitry
