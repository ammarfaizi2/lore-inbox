Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbWBOUlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbWBOUlL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 15:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbWBOUlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 15:41:11 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:23295 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S932461AbWBOUlK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 15:41:10 -0500
Date: Wed, 15 Feb 2006 12:40:21 -0800 (PST)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Jesper Juhl <jesper.juhl@gmail.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: pid_t range question
In-Reply-To: <Pine.LNX.4.61.0602101420550.31246@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.62.0602151238520.5446@qynat.qvtvafvgr.pbz>
References: <Pine.LNX.4.61.0602071122520.327@chaos.analogic.com>
 <m1pslystkz.fsf@ebiederm.dsl.xmission.com> 
 <Pine.LNX.4.61.0602091751220.30108@yvahk01.tjqt.qr><m1r76c2yhf.fsf@ebiederm.dsl.xmission.com><9a8748490602091213p2e020355ue516d59b7d0b6c81@mail.gmail.com>
 <Pine.LNX.4.61.0602101420550.31246@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Feb 2006, Jan Engelhardt wrote:

>> Any of those 3 scheemes should keep pids below 6 digits as much as
>> possible. We can still hit the cosmetic problem on boxes where more
>> than 99999 processes are actually running at the same time, but most
>> users will never encounter that.
>>
> I'd say let's remain doing whatever we're doing now. That is, a maximum of
> 32768 concurrent pids, and whoever needs more (e.g. Sourceforge shell,
> etc.) can always raise it to their needs.

when you say 'continue doing what we are doing now' do you mean to include 
the hard-coded limit of 32K pids? or do you mean to not worry about the 
cosmetic issue and change the code to not hard-code the limit, but instead 
honor a max_pid >32K?

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

