Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271283AbRHXNPl>; Fri, 24 Aug 2001 09:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271371AbRHXNPb>; Fri, 24 Aug 2001 09:15:31 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:35342 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S271283AbRHXNPT>;
	Fri, 24 Aug 2001 09:15:19 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: David Woodhouse <dwmw2@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: macro conflict 
In-Reply-To: Your message of "Fri, 24 Aug 2001 14:03:34 +0100."
             <14764.998658214@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 24 Aug 2001 23:15:29 +1000
Message-ID: <6208.998658929@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2001 14:03:34 +0100, 
David Woodhouse <dwmw2@infradead.org> wrote:
>#define min(x,y) ({ if strcmp(STRINGIFY(typeof(x)), STRINGIFY(typeof(y))) BUG(); realmin(x,y) }) 

Did you try that?  Firstly typeof() is only defined in declaration
context, it gets an error when used in an expression.  Secondly
typeof() is not expanded by cpp so the stringify tricks do not work.
typeof(x) is handled by cc, not cpp.

