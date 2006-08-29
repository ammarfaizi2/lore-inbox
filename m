Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbWH2Fng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWH2Fng (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 01:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWH2Fng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 01:43:36 -0400
Received: from science.horizon.com ([192.35.100.1]:23106 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751141AbWH2Fng
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 01:43:36 -0400
Date: 29 Aug 2006 01:43:34 -0400
Message-ID: <20060829054334.24362.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: Re: Conversion to generic boolean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have to say, I think <stdbool.h> is a Very Good Thing.

There are actually two stnadard C conventions for boolean return codes:
1) 0 = false, 1 = true
2) 0 = success, -1 = failure (or generally >= 0 and < 0)

I generally like true = success, false = failure, which can require some
edits of all the call sites if converting from the second convention.

But in either case, I'd much rather have a function declated "bool"
than "int", becuase then I *know* there are only two return values,
and nobody has invented a return value of 2 for some reason.

And, as others have noticed, the compiler can optimize using that
information, too.

(Conversely, if the convention to use bool where possible is
well-established, then if you see "int", you *know* there are more than
two possible return values.)


I'm all for just #include <stdbool.h> and use "bool", "true" and "false".
