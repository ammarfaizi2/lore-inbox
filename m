Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263967AbTDIW31 (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 18:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263970AbTDIW31 (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 18:29:27 -0400
Received: from nycsmtp5out-eri0.rdc-nyc.rr.com ([24.29.99.228]:40836 "EHLO
	nycsmtp5out-eri0.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S263967AbTDIW3U (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 18:29:20 -0400
Message-ID: <3E94A1B4.6020602@si.rr.com>
Date: Wed, 09 Apr 2003 18:41:56 -0400
From: Frank Davis <fdavis@si.rr.com>
Reply-To: fdavis@si.rr.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: kernel support for non-english user messages
References: <3E93A958.80107@si.rr.com> <20030409080803.GC29167@mea-ext.zmailer.org> <20030409080803.GC29167@mea-ext.zmailer.org> <20030409190700.H19288@almesberger.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How about unifying the printk text messages into a limited set of 
common/canned text statements? If that could be done, all that would be 
needed in the kernel would be a small language translation table. The 
output of the table, based on the english input and the user's language 
setting, would be sent to the administrator/user.

On a similar note, Andreas Dilger mentioned this suggestion earlier, 
which it seems has been echoed by others, and that might be agreeable...

"My suggestion would be to add the required i18n support to klogd, so 
that kernel messages are translated as they are removed from dmesg into 
syslog. Then, like any i18n support, you build a message catalog from 
the printk strings in the kernel and have klogd do the 
lookups/translation in user space."

Regards,
Frank


Werner Almesberger wrote:
> Matti Aarnio wrote:
> 
> Nobody is going to maintain all the translations of "his" component,
> so you might as well let the translators try to play catch-up, and
> track changes in their regexp database.
> 
> For the kernel, we don't have the mechanisms of big companies or
> monolithic projects to just funnel all changes of a specific kind
> through a single channel, where somebody slaps a unique message-id
> on them.
> 
> Granted, you can have multi-level messages (like the VMS-style
> %facility-severity-ident), but that only buys some time. And you
> still either need a message catalog or include the plain text in
> the message as well.
> 
> The message catalog only approach wouldn't work well for the kernel,
> yielding either too many files or patch congestion on central
> message files. Think of Documentation/Configure.help and the
> relative frequency of changes.
> 
> And if you have the (English) plain text, you almost always also
> have your unique message key. At least unique enough for
> translation. So perhaps it's time to forget the traditional
> solutions, and think of a more distributed approach.
> 
> - Werner
> 


