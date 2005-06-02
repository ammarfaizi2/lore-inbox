Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbVFBQMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVFBQMu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 12:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbVFBQMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 12:12:37 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:11460 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S261179AbVFBQLX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 12:11:23 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Lukasz Stelmach <stlman@poczta.fm>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [OT] mailing list management 
In-reply-to: Your message of "Wed, 01 Jun 2005 11:49:08 +0100."
             <429D92A4.1060103@grupopie.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 Jun 2005 02:11:05 +1000
Message-ID: <4889.1117728665@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Jun 2005 11:49:08 +0100, 
Paulo Marques <pmarques@grupopie.com> wrote:
>The thing is, this list has a lot of traffic (as you might have noticed 
>:), and sometimes people don't have time to go through all the emails, 
>and just take special attention at mails directed at them personally.

"There is always more than one way to do things".

~/.procmailrc

#################################################################
# If my address appears in To:, Cc: or Bcc: then add X-To-Me: YES
#################################################################

:0 Whc
| formail -c -x to -x cc -x bcc | egrep -i 'some expression' > /dev/null
:0 aWhf
| formail -A 'X-Personal: YES'

Replace some expression with a grep expression that matches all email
addresses that you consider personal.  Such mail on any list gets the
line 'X-Personal: YES' added, which makes it trivial to file or index
them separately.

To suppress duplicate messages, also in .procmailrc

:0 Wh: msgid.lock
| formail -D 20000 msgid.cache

