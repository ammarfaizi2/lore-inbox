Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbWA3Jos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWA3Jos (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 04:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWA3Jos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 04:44:48 -0500
Received: from smtpout06-01.prod.mesa1.secureserver.net ([64.202.165.224]:8654
	"HELO smtpout06-04.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S932171AbWA3Jor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 04:44:47 -0500
Message-ID: <43DDE009.9090104@sairyx.org>
Date: Mon, 30 Jan 2006 20:44:41 +1100
From: Yuki Cuss <celtic@sairyx.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pid: Don't hash pid 0.
References: <m1ek2rfsu9.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.61.0601301028510.6405@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0601301028510.6405@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:

>>@@ -148,6 +148,9 @@ int fastcall attach_pid(task_t *task, en
>>{
>>	struct pid *pid, *task_pid;
>>
>>+	if (!nr)
>>+		goto out;
>>+
>>    
>>
>
>How about nr==0, it would make it more obvious.
>
>
>
>Jan Engelhardt
>  
>

I am inclined to agree. `!nr' seems to imply some sort of an error 
condition; perhaps a comment could be placed in order to make why the 
case of (nr == 0) is being ignored.

 - Yuki.
