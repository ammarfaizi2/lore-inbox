Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318813AbSHSMf6>; Mon, 19 Aug 2002 08:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318830AbSHSMf6>; Mon, 19 Aug 2002 08:35:58 -0400
Received: from radio-112-20.poa.terraempresas.com.br ([200.176.112.20]:57356
	"EHLO rush.interage.com.br") by vger.kernel.org with ESMTP
	id <S318813AbSHSMf4>; Mon, 19 Aug 2002 08:35:56 -0400
Message-ID: <3D60E729.2090209@interage.com.br>
Date: Mon, 19 Aug 2002 09:40:09 -0300
From: Mauricio Pretto <pretto@interage.com.br>
Organization: Interage Integradora
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us, pt-br
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre3 boot hang
References: <20020818153145.GA3184@df1tlpc.local.here> <3D60D2DB.3050202@interage.com.br> <20020819113849.GA352@hendrix>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok It worked Here, Boots Ok.
Thanks


Skidley wrote:

> On Mon, Aug 19, 2002 at 08:13:31AM -0300, Mauricio Pretto wrote:
> 
>>Same Problem Here, athlon 1.1 , Right after Rt netlink socket it hangs.
>>My .config goes attach.
>>
>>
>>Klaus Dittrich wrote:
>>
>>
>>>SMP, P-III, Intel-BX
>>>
>>>booting Linux 2.4.20-pre3 stops after 
>>>
>>>Linux NET4.0 for Linux 2.4 
>>>Based upon Swansea University Computer Society NET3.039 
>>>Initializing RT netlink socket 
>>>
>>>
>>>
>>
>>-- 
>>Mauricio Pretto
>>Gerente de Produtos
>>Interage Integradora
>>http://www.interage.com.br
>>
>>T?cnico Certificado Conectiva Linux
>>
> 
> This patch was posted to lkml earlier, it fixed the same problem for me:
> 
> 
> diff -urN linux-2.4/kernel/sched.c pmac/kernel/sched.c
> --- linux-2.4/kernel/sched.c	Wed Aug  7 18:10:01 2002
> +++ pmac/kernel/sched.c	Mon Aug 19 10:39:39 2002
> @@ -1081,6 +1081,7 @@
>  {
>  	set_current_state(TASK_RUNNING);
>  	sys_sched_yield();
> +	schedule();
>  }
>  
>  void __cond_resched(void)
> 
> 


-- 
Mauricio Pretto
Gerente de Produtos
Interage Integradora
http://www.interage.com.br

Técnico Certificado Conectiva Linux

