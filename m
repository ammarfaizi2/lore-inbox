Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267532AbTACOpL>; Fri, 3 Jan 2003 09:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267534AbTACOpL>; Fri, 3 Jan 2003 09:45:11 -0500
Received: from pusa.informat.uv.es ([147.156.10.98]:58580 "EHLO
	pusa.informat.uv.es") by vger.kernel.org with ESMTP
	id <S267532AbTACOpK>; Fri, 3 Jan 2003 09:45:10 -0500
Date: Fri, 3 Jan 2003 15:53:37 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: [STUPID] Best looking code to transfer to a t-shirt
Message-ID: <20030103145337.GA1986@pusa.informat.uv.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: uaca@alumni.uv.es
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Maciej

On Fri, Jan 03, 2003 at 02:25:09PM +0100, Maciej Soltysiak wrote:
> Hi,
> 
[...]
> How about we have a poll of the most frightening pieces of the kernel ?
> What are your ideas?

Do you like this one?

/*
 * We use this if we don't have any better
 * idle routine..
 */
void default_idle(void)
{
        if (current_cpu_data.hlt_works_ok && !hlt_counter) {
                __cli();
                if (!current->need_resched)
                        safe_halt();
                else
                        __sti();
        }
}


	Ulisses

                Debian GNU/Linux: a dream come true
-----------------------------------------------------------------------------
"Computers are useless. They can only give answers."            Pablo Picasso

--->	Visita http://www.valux.org/ para saber acerca de la	<---
--->	Asociación Valenciana de Usuarios de Linux		<---
