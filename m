Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161027AbVKXG5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161027AbVKXG5N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 01:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161025AbVKXG5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 01:57:13 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:12002 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1161024AbVKXG5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 01:57:10 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Dave Jones <davej@redhat.com>
Subject: Re: Kernel BUG at mm/rmap.c:491
Date: Thu, 24 Nov 2005 06:57:11 +0000
User-Agent: KMail/1.9
Cc: Con Kolivas <con@kolivas.org>, Kenneth W <kenneth.w.chen@intel.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <200511232256.jANMuGg20547@unix-os.sc.intel.com> <200511232335.15050.s0348365@sms.ed.ac.uk> <20051124044009.GE30849@redhat.com>
In-Reply-To: <20051124044009.GE30849@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511240657.11480.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 November 2005 04:40, Dave Jones wrote:
> On Wed, Nov 23, 2005 at 11:35:15PM +0000, Alistair John Strachan wrote:
>  > On Wednesday 23 November 2005 23:24, Con Kolivas wrote:
>  > > Chen, Kenneth W writes:
>  > > > Has people seen this BUG_ON before?  On 2.6.15-rc2, x86-64.
>  > > >
>  > > > Pid: 16500, comm: cc1 Tainted: G    B 2.6.15-rc2 #3
>  > > >
>  > > > Pid: 16651, comm: sh Tainted: G    B 2.6.15-rc2 #3
>  > >
>  > >                        ^^^^^^^^^^
>  > >
>  > > Please try to reproduce it without proprietary binary modules linked
>  > > in.
>  >
>  > AFAIK "G" means all loaded modules are GPL, P is for proprietary
>  > modules.
>
> The 'G' seems to confuse a hell of a lot of people.
> (I've been asked about it when people got machine checks a lot over
>  the last few months).
>
> Would anyone object to changing it to conform to the style of
> the other taint flags ? Ie, change it to ' ' ?

I don't understand the reasons for making the tainted string all the same 
length anyway. Why not just remove all the extra spaces?

Unless you know what you're looking for, I can assure you that:

Tainted: G    B SOMEOTHERTEXT

Is not intuitively readable (which text does B belong to?).

Tainted:    B SOMEOTHERTEXT

Is better, but still not very good. Why not drop the spaces?

3rd party parsing purposes?

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
