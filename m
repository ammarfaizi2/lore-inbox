Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267401AbUJGLLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267401AbUJGLLl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 07:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267391AbUJGLLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 07:11:41 -0400
Received: from main.gmane.org ([80.91.229.2]:17048 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S269793AbUJGLKo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 07:10:44 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@mru.ath.cx>
Subject: Re: High pitched noise from laptop: processor.c in linux 2.6
Date: Thu, 07 Oct 2004 12:53:00 +0200
Message-ID: <yw1x7jq2n6k3.fsf@mru.ath.cx>
References: <41650CAF.1040901@unimail.com.au> <20041007103210.GA32260@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 197.80-202-92.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:3sxVONCGlUTwbrwK/WhUi7Ktflw=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> Hi!
>
>> I recently upgraded from linux 2.4.27 to 2.6.8.1 and noticed my laptop 
>> now makes a high pitch noise while idle. I traced it back to the 
>> processor module for acpi. 'rmmod processor' stops the noise. 
>> 
>> 
>> 
>> Using speed step to turn it down to 733 Mhz makes it a 
>>        little quieter and doesn't change the tone. 
>> 
>> 
>> 
>> Is there any way to stop this? I googled around and found it had 
>> something to do with idle frequency of 1000 Hz in 2.6 instead of 100Hz 
>> in the 2.4 kernel. I couldn't find much else on this. Hunting around the 
>> code didn't help much, I don't know C. 
>
> Change #define HZ 1000 to #define HZ 100...

... and lose all the benefits of HZ=1000.  What would happen if one
were to set HZ to a higher value, like 10000?

> Ouch and btw it is hardware problem -- too cheap capacitors.
> 								Pavel
> -- 
> Boycott Kodak -- for their patent abuse against Java.

Actually, I don't know which is worse, patent abuse or Java misuse.

-- 
Måns Rullgård
mru@mru.ath.cx

