Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264233AbTDJXOr (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 19:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264236AbTDJXOr (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 19:14:47 -0400
Received: from siaab1aa.compuserve.com ([149.174.40.1]:63162 "EHLO
	siaab1aa.compuserve.com") by vger.kernel.org with ESMTP
	id S264233AbTDJXOr (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 19:14:47 -0400
Date: Thu, 10 Apr 2003 19:23:50 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: kernel support for non-english user messages
To: Bernd Petrovitsch <bernd@gams.at>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304101926_MC3-1-33EA-AB12@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> "%s: name %p is %d\n", "stringval", 0x4790243, 44
>[...]
>> The real problem I see is that this approach doesn't make it any
>>easier to translate the messages.
>
>If you habe the above, you could use/copy/reuse gettext() since the 
>format string is used a key/hash/unique id for the translation.


 If all you need is the hash of the format string, why not put that
at the end of the log message, i.e.

  <severity>message<hash>

(Note this is the hash of the *format* string, not the message.)

This would be nearly-trivial to do.


--
 Chuck
