Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbULER0C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbULER0C (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 12:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbULERUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 12:20:47 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:10507 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261335AbULERJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 12:09:50 -0500
Date: Sun, 5 Dec 2004 18:09:44 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] char/pcmcia/synclink_cs.: make some functions static
Message-ID: <20041205170944.GV2953@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes some needlessly global functions static.


diffstat output:
 drivers/char/pcmcia/synclink_cs.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/char/synclink.c.old	2004-11-07 00:59:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/synclink.c	2004-11-07 01:42:07.000000000 +0100
@@ -53,7 +53,6 @@
  * OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-#define VERSION(ver,rel,seq) (((ver)<<16) | ((rel)<<8) | (seq))
 #if defined(__i386__)
 #  define BREAKPOINT() asm("   int $3");
 #else
@@ -118,7 +117,7 @@
 
 #define RCLRVALUE 0xffff
 
-MGSL_PARAMS default_params = {
+static MGSL_PARAMS default_params = {
 	MGSL_MODE_HDLC,			/* unsigned long mode */
 	0,				/* unsigned char loopback; */
 	HDLC_FLAG_UNDERRUN_ABORT15,	/* unsigned short flags; */
@@ -679,13 +678,13 @@
 #define usc_EnableReceiver(a,b) \
 	usc_OutReg( (a), RMR, (u16)((usc_InReg((a),RMR) & 0xfffc) | (b)) )
 
-u16  usc_InDmaReg( struct mgsl_struct *info, u16 Port );
-void usc_OutDmaReg( struct mgsl_struct *info, u16 Port, u16 Value );
-void usc_DmaCmd( struct mgsl_struct *info, u16 Cmd );
-
-u16  usc_InReg( struct mgsl_struct *info, u16 Port );
-void usc_OutReg( struct mgsl_struct *info, u16 Port, u16 Value );
-void usc_RTCmd( struct mgsl_struct *info, u16 Cmd );
+static u16  usc_InDmaReg( struct mgsl_struct *info, u16 Port );
+static void usc_OutDmaReg( struct mgsl_struct *info, u16 Port, u16 Value );
+static void usc_DmaCmd( struct mgsl_struct *info, u16 Cmd );
+
+static u16  usc_InReg( struct mgsl_struct *info, u16 Port );
+static void usc_OutReg( struct mgsl_struct *info, u16 Port, u16 Value );
+static void usc_RTCmd( struct mgsl_struct *info, u16 Cmd );
 void usc_RCmd( struct mgsl_struct *info, u16 Cmd );
 void usc_TCmd( struct mgsl_struct *info, u16 Cmd );
 
@@ -694,40 +693,39 @@
 
 #define usc_SetTransmitSyncChars(a,s0,s1) usc_OutReg((a), TSR, (u16)(((u16)s0<<8)|(u16)s1))
 
-void usc_process_rxoverrun_sync( struct mgsl_struct *info );
-void usc_start_receiver( struct mgsl_struct *info );
-void usc_stop_receiver( struct mgsl_struct *info );
+static void usc_process_rxoverrun_sync( struct mgsl_struct *info );
+static void usc_start_receiver( struct mgsl_struct *info );
+static void usc_stop_receiver( struct mgsl_struct *info );
 
-void usc_start_transmitter( struct mgsl_struct *info );
-void usc_stop_transmitter( struct mgsl_struct *info );
-void usc_set_txidle( struct mgsl_struct *info );
-void usc_load_txfifo( struct mgsl_struct *info );
+static void usc_start_transmitter( struct mgsl_struct *info );
+static void usc_stop_transmitter( struct mgsl_struct *info );
+static void usc_set_txidle( struct mgsl_struct *info );
+static void usc_load_txfifo( struct mgsl_struct *info );
 
-void usc_enable_aux_clock( struct mgsl_struct *info, u32 DataRate );
-void usc_enable_loopback( struct mgsl_struct *info, int enable );
+static void usc_enable_aux_clock( struct mgsl_struct *info, u32 DataRate );
+static void usc_enable_loopback( struct mgsl_struct *info, int enable );
 
-void usc_get_serial_signals( struct mgsl_struct *info );
-void usc_set_serial_signals( struct mgsl_struct *info );
+static void usc_get_serial_signals( struct mgsl_struct *info );
+static void usc_set_serial_signals( struct mgsl_struct *info );
 
-void usc_reset( struct mgsl_struct *info );
+static void usc_reset( struct mgsl_struct *info );
 
-void usc_set_sync_mode( struct mgsl_struct *info );
-void usc_set_sdlc_mode( struct mgsl_struct *info );
-void usc_set_async_mode( struct mgsl_struct *info );
-void usc_enable_async_clock( struct mgsl_struct *info, u32 DataRate );
+static void usc_set_sync_mode( struct mgsl_struct *info );
+static void usc_set_sdlc_mode( struct mgsl_struct *info );
+static void usc_set_async_mode( struct mgsl_struct *info );
+static void usc_enable_async_clock( struct mgsl_struct *info, u32 DataRate );
 
-void usc_loopback_frame( struct mgsl_struct *info );
+static void usc_loopback_frame( struct mgsl_struct *info );
 
-void mgsl_tx_timeout(unsigned long context);
+static void mgsl_tx_timeout(unsigned long context);
 
 
-void usc_loopmode_cancel_transmit( struct mgsl_struct * info );
-void usc_loopmode_insert_request( struct mgsl_struct * info );
-int usc_loopmode_active( struct mgsl_struct * info);
-void usc_loopmode_send_done( struct mgsl_struct * info );
-int usc_loopmode_send_active( struct mgsl_struct * info );
+static void usc_loopmode_cancel_transmit( struct mgsl_struct * info );
+static void usc_loopmode_insert_request( struct mgsl_struct * info );
+static int usc_loopmode_active( struct mgsl_struct * info);
+static void usc_loopmode_send_done( struct mgsl_struct * info );
 
-int mgsl_ioctl_common(struct mgsl_struct *info, unsigned int cmd, unsigned long arg);
+static int mgsl_ioctl_common(struct mgsl_struct *info, unsigned int cmd, unsigned long arg);
 
 #ifdef CONFIG_HDLC
 #define dev_to_port(D) (dev_to_hdlc(D)->priv)
@@ -753,77 +751,77 @@
 ((Nrdd)   << 11) + \
 ((Nrad)   <<  6) )
 
-void mgsl_trace_block(struct mgsl_struct *info,const char* data, int count, int xmit);
+static void mgsl_trace_block(struct mgsl_struct *info,const char* data, int count, int xmit);
 
 /*
  * Adapter diagnostic routines
  */
-BOOLEAN mgsl_register_test( struct mgsl_struct *info );
-BOOLEAN mgsl_irq_test( struct mgsl_struct *info );
-BOOLEAN mgsl_dma_test( struct mgsl_struct *info );
-BOOLEAN mgsl_memory_test( struct mgsl_struct *info );
-int mgsl_adapter_test( struct mgsl_struct *info );
+static BOOLEAN mgsl_register_test( struct mgsl_struct *info );
+static BOOLEAN mgsl_irq_test( struct mgsl_struct *info );
+static BOOLEAN mgsl_dma_test( struct mgsl_struct *info );
+static BOOLEAN mgsl_memory_test( struct mgsl_struct *info );
+static int mgsl_adapter_test( struct mgsl_struct *info );
 
 /*
  * device and resource management routines
  */
-int mgsl_claim_resources(struct mgsl_struct *info);
-void mgsl_release_resources(struct mgsl_struct *info);
-void mgsl_add_device(struct mgsl_struct *info);
-struct mgsl_struct* mgsl_allocate_device(void);
+static int mgsl_claim_resources(struct mgsl_struct *info);
+static void mgsl_release_resources(struct mgsl_struct *info);
+static void mgsl_add_device(struct mgsl_struct *info);
+static struct mgsl_struct* mgsl_allocate_device(void);
 
 /*
  * DMA buffer manupulation functions.
  */
-void mgsl_free_rx_frame_buffers( struct mgsl_struct *info, unsigned int StartIndex, unsigned int EndIndex );
-int  mgsl_get_rx_frame( struct mgsl_struct *info );
-int  mgsl_get_raw_rx_frame( struct mgsl_struct *info );
-void mgsl_reset_rx_dma_buffers( struct mgsl_struct *info );
-void mgsl_reset_tx_dma_buffers( struct mgsl_struct *info );
-int num_free_tx_dma_buffers(struct mgsl_struct *info);
-void mgsl_load_tx_dma_buffer( struct mgsl_struct *info, const char *Buffer, unsigned int BufferSize);
-void mgsl_load_pci_memory(char* TargetPtr, const char* SourcePtr, unsigned short count);
+static void mgsl_free_rx_frame_buffers( struct mgsl_struct *info, unsigned int StartIndex, unsigned int EndIndex );
+static int  mgsl_get_rx_frame( struct mgsl_struct *info );
+static int  mgsl_get_raw_rx_frame( struct mgsl_struct *info );
+static void mgsl_reset_rx_dma_buffers( struct mgsl_struct *info );
+static void mgsl_reset_tx_dma_buffers( struct mgsl_struct *info );
+static int num_free_tx_dma_buffers(struct mgsl_struct *info);
+static void mgsl_load_tx_dma_buffer( struct mgsl_struct *info, const char *Buffer, unsigned int BufferSize);
+static void mgsl_load_pci_memory(char* TargetPtr, const char* SourcePtr, unsigned short count);
 
 /*
  * DMA and Shared Memory buffer allocation and formatting
  */
-int  mgsl_allocate_dma_buffers(struct mgsl_struct *info);
-void mgsl_free_dma_buffers(struct mgsl_struct *info);
-int  mgsl_alloc_frame_memory(struct mgsl_struct *info, DMABUFFERENTRY *BufferList,int Buffercount);
-void mgsl_free_frame_memory(struct mgsl_struct *info, DMABUFFERENTRY *BufferList,int Buffercount);
-int  mgsl_alloc_buffer_list_memory(struct mgsl_struct *info);
-void mgsl_free_buffer_list_memory(struct mgsl_struct *info);
-int mgsl_alloc_intermediate_rxbuffer_memory(struct mgsl_struct *info);
-void mgsl_free_intermediate_rxbuffer_memory(struct mgsl_struct *info);
-int mgsl_alloc_intermediate_txbuffer_memory(struct mgsl_struct *info);
-void mgsl_free_intermediate_txbuffer_memory(struct mgsl_struct *info);
-int load_next_tx_holding_buffer(struct mgsl_struct *info);
-int save_tx_buffer_request(struct mgsl_struct *info,const char *Buffer, unsigned int BufferSize);
+static int  mgsl_allocate_dma_buffers(struct mgsl_struct *info);
+static void mgsl_free_dma_buffers(struct mgsl_struct *info);
+static int  mgsl_alloc_frame_memory(struct mgsl_struct *info, DMABUFFERENTRY *BufferList,int Buffercount);
+static void mgsl_free_frame_memory(struct mgsl_struct *info, DMABUFFERENTRY *BufferList,int Buffercount);
+static int  mgsl_alloc_buffer_list_memory(struct mgsl_struct *info);
+static void mgsl_free_buffer_list_memory(struct mgsl_struct *info);
+static int mgsl_alloc_intermediate_rxbuffer_memory(struct mgsl_struct *info);
+static void mgsl_free_intermediate_rxbuffer_memory(struct mgsl_struct *info);
+static int mgsl_alloc_intermediate_txbuffer_memory(struct mgsl_struct *info);
+static void mgsl_free_intermediate_txbuffer_memory(struct mgsl_struct *info);
+static int load_next_tx_holding_buffer(struct mgsl_struct *info);
+static int save_tx_buffer_request(struct mgsl_struct *info,const char *Buffer, unsigned int BufferSize);
 
 /*
  * Bottom half interrupt handlers
  */
-void mgsl_bh_handler(void* Context);
-void mgsl_bh_receive(struct mgsl_struct *info);
-void mgsl_bh_transmit(struct mgsl_struct *info);
-void mgsl_bh_status(struct mgsl_struct *info);
+static void mgsl_bh_handler(void* Context);
+static void mgsl_bh_receive(struct mgsl_struct *info);
+static void mgsl_bh_transmit(struct mgsl_struct *info);
+static void mgsl_bh_status(struct mgsl_struct *info);
 
 /*
  * Interrupt handler routines and dispatch table.
  */
-void mgsl_isr_null( struct mgsl_struct *info );
-void mgsl_isr_transmit_data( struct mgsl_struct *info );
-void mgsl_isr_receive_data( struct mgsl_struct *info );
-void mgsl_isr_receive_status( struct mgsl_struct *info );
-void mgsl_isr_transmit_status( struct mgsl_struct *info );
-void mgsl_isr_io_pin( struct mgsl_struct *info );
-void mgsl_isr_misc( struct mgsl_struct *info );
-void mgsl_isr_receive_dma( struct mgsl_struct *info );
-void mgsl_isr_transmit_dma( struct mgsl_struct *info );
+static void mgsl_isr_null( struct mgsl_struct *info );
+static void mgsl_isr_transmit_data( struct mgsl_struct *info );
+static void mgsl_isr_receive_data( struct mgsl_struct *info );
+static void mgsl_isr_receive_status( struct mgsl_struct *info );
+static void mgsl_isr_transmit_status( struct mgsl_struct *info );
+static void mgsl_isr_io_pin( struct mgsl_struct *info );
+static void mgsl_isr_misc( struct mgsl_struct *info );
+static void mgsl_isr_receive_dma( struct mgsl_struct *info );
+static void mgsl_isr_transmit_dma( struct mgsl_struct *info );
 
 typedef void (*isr_dispatch_func)(struct mgsl_struct *);
 
-isr_dispatch_func UscIsrTable[7] =
+static isr_dispatch_func UscIsrTable[7] =
 {
 	mgsl_isr_null,
 	mgsl_isr_misc,
@@ -858,7 +856,7 @@
 /*
  * Global linked list of SyncLink devices
  */
-struct mgsl_struct *mgsl_device_list;
+static struct mgsl_struct *mgsl_device_list;
 static int mgsl_device_count;
 
 /*
@@ -935,7 +933,7 @@
  * (gdb) to get the .text address for the add-symbol-file command.
  * This allows remote debugging of dynamically loadable modules.
  */
-void* mgsl_get_text_ptr(void)
+static void* mgsl_get_text_ptr(void)
 {
 	return mgsl_get_text_ptr;
 }
@@ -1052,7 +1050,7 @@
 /* mgsl_bh_action()	Return next bottom half action to perform.
  * Return Value:	BH action code or 0 if nothing to do.
  */
-int mgsl_bh_action(struct mgsl_struct *info)
+static int mgsl_bh_action(struct mgsl_struct *info)
 {
 	unsigned long flags;
 	int rc = 0;
@@ -1084,7 +1082,7 @@
 /*
  * 	Perform bottom half processing of work items queued by ISR.
  */
-void mgsl_bh_handler(void* Context)
+static void mgsl_bh_handler(void* Context)
 {
 	struct mgsl_struct *info = (struct mgsl_struct*)Context;
 	int action;
@@ -1128,7 +1126,7 @@
 			__FILE__,__LINE__,info->device_name);
 }
 
-void mgsl_bh_receive(struct mgsl_struct *info)
+static void mgsl_bh_receive(struct mgsl_struct *info)
 {
 	int (*get_rx_frame)(struct mgsl_struct *info) =
 		(info->params.mode == MGSL_MODE_HDLC ? mgsl_get_rx_frame : mgsl_get_raw_rx_frame);
@@ -1149,7 +1147,7 @@
 	} while(get_rx_frame(info));
 }
 
-void mgsl_bh_transmit(struct mgsl_struct *info)
+static void mgsl_bh_transmit(struct mgsl_struct *info)
 {
 	struct tty_struct *tty = info->tty;
 	unsigned long flags;
@@ -1172,7 +1170,7 @@
 	spin_unlock_irqrestore(&info->irq_spinlock,flags);
 }
 
-void mgsl_bh_status(struct mgsl_struct *info)
+static void mgsl_bh_status(struct mgsl_struct *info)
 {
 	if ( debug_level >= DEBUG_LEVEL_BH )
 		printk( "%s(%d):mgsl_bh_status() entry on %s\n",
@@ -1193,7 +1191,7 @@
  * Arguments:		info	pointer to device instance data
  * Return Value:	None
  */
-void mgsl_isr_receive_status( struct mgsl_struct *info )
+static void mgsl_isr_receive_status( struct mgsl_struct *info )
 {
 	u16 status = usc_InReg( info, RCSR );
 
@@ -1245,7 +1243,7 @@
  * Arguments:		info	       pointer to device instance data
  * Return Value:	None
  */
-void mgsl_isr_transmit_status( struct mgsl_struct *info )
+static void mgsl_isr_transmit_status( struct mgsl_struct *info )
 {
 	u16 status = usc_InReg( info, TCSR );
 
@@ -1312,7 +1310,7 @@
  * Arguments:		info	       pointer to device instance data
  * Return Value:	None
  */
-void mgsl_isr_io_pin( struct mgsl_struct *info )
+static void mgsl_isr_io_pin( struct mgsl_struct *info )
 {
  	struct	mgsl_icount *icount;
 	u16 status = usc_InReg( info, MISR );
@@ -1430,7 +1428,7 @@
  * Arguments:		info	pointer to device instance data
  * Return Value:	None
  */
-void mgsl_isr_transmit_data( struct mgsl_struct *info )
+static void mgsl_isr_transmit_data( struct mgsl_struct *info )
 {
 	if ( debug_level >= DEBUG_LEVEL_ISR )	
 		printk("%s(%d):mgsl_isr_transmit_data xmit_cnt=%d\n",
@@ -1462,7 +1460,7 @@
  * Arguments:		info		pointer to device instance data
  * Return Value:	None
  */
-void mgsl_isr_receive_data( struct mgsl_struct *info )
+static void mgsl_isr_receive_data( struct mgsl_struct *info )
 {
 	int Fifocount;
 	u16 status;
@@ -1574,7 +1572,7 @@
  * Arguments:		info		pointer to device extension (instance data)
  * Return Value:	None
  */
-void mgsl_isr_misc( struct mgsl_struct *info )
+static void mgsl_isr_misc( struct mgsl_struct *info )
 {
 	u16 status = usc_InReg( info, MISR );
 
@@ -1610,7 +1608,7 @@
  * Arguments:		info		pointer to device extension (instance data)
  * Return Value:	None
  */
-void mgsl_isr_null( struct mgsl_struct *info )
+static void mgsl_isr_null( struct mgsl_struct *info )
 {
 
 }	/* end of mgsl_isr_null() */
@@ -1634,7 +1632,7 @@
  * Arguments:		info		pointer to device instance data
  * Return Value:	None
  */
-void mgsl_isr_receive_dma( struct mgsl_struct *info )
+static void mgsl_isr_receive_dma( struct mgsl_struct *info )
 {
 	u16 status;
 	
@@ -1678,7 +1676,7 @@
  * Arguments:		info		pointer to device instance data
  * Return Value:	None
  */
-void mgsl_isr_transmit_dma( struct mgsl_struct *info )
+static void mgsl_isr_transmit_dma( struct mgsl_struct *info )
 {
 	u16 status;
 
@@ -2990,7 +2988,7 @@
 	return mgsl_ioctl_common(info, cmd, arg);
 }
 
-int mgsl_ioctl_common(struct mgsl_struct *info, unsigned int cmd, unsigned long arg)
+static int mgsl_ioctl_common(struct mgsl_struct *info, unsigned int cmd, unsigned long arg)
 {
 	int error;
 	struct mgsl_icount cnow;	/* kernel counter temps */
@@ -3649,7 +3647,7 @@
  * 	
  * Return Value:
  */
-int mgsl_read_proc(char *page, char **start, off_t off, int count,
+static int mgsl_read_proc(char *page, char **start, off_t off, int count,
 		 int *eof, void *data)
 {
 	int len = 0, l;
@@ -3688,7 +3686,7 @@
  * Arguments:		info	pointer to device instance data
  * Return Value:	0 if success, otherwise error
  */
-int mgsl_allocate_dma_buffers(struct mgsl_struct *info)
+static int mgsl_allocate_dma_buffers(struct mgsl_struct *info)
 {
 	unsigned short BuffersPerFrame;
 
@@ -3795,7 +3793,7 @@
  * Arguments:		info	pointer to device instance data
  * Return Value:	0 if success, otherwise error
  */
-int mgsl_alloc_buffer_list_memory( struct mgsl_struct *info )
+static int mgsl_alloc_buffer_list_memory( struct mgsl_struct *info )
 {
 	unsigned int i;
 
@@ -3880,7 +3878,7 @@
  * 	the buffer list contains the information necessary to free
  * 	the individual buffers!
  */
-void mgsl_free_buffer_list_memory( struct mgsl_struct *info )
+static void mgsl_free_buffer_list_memory( struct mgsl_struct *info )
 {
 	if ( info->buffer_list && info->bus_type != MGSL_BUS_TYPE_PCI )
 		kfree(info->buffer_list);
@@ -3907,7 +3905,7 @@
  * 
  * Return Value:	0 if success, otherwise -ENOMEM
  */
-int mgsl_alloc_frame_memory(struct mgsl_struct *info,DMABUFFERENTRY *BufferList,int Buffercount)
+static int mgsl_alloc_frame_memory(struct mgsl_struct *info,DMABUFFERENTRY *BufferList,int Buffercount)
 {
 	int i;
 	unsigned long phys_addr;
@@ -3949,7 +3947,7 @@
  * 
  * Return Value:	None
  */
-void mgsl_free_frame_memory(struct mgsl_struct *info, DMABUFFERENTRY *BufferList, int Buffercount)
+static void mgsl_free_frame_memory(struct mgsl_struct *info, DMABUFFERENTRY *BufferList, int Buffercount)
 {
 	int i;
 
@@ -3972,7 +3970,7 @@
  * Arguments:		info	pointer to device instance data
  * Return Value:	None
  */
-void mgsl_free_dma_buffers( struct mgsl_struct *info )
+static void mgsl_free_dma_buffers( struct mgsl_struct *info )
 {
 	mgsl_free_frame_memory( info, info->rx_buffer_list, info->rx_buffer_count );
 	mgsl_free_frame_memory( info, info->tx_buffer_list, info->tx_buffer_count );
@@ -3993,7 +3991,7 @@
  * 
  * Return Value:	0 if success, otherwise -ENOMEM
  */
-int mgsl_alloc_intermediate_rxbuffer_memory(struct mgsl_struct *info)
+static int mgsl_alloc_intermediate_rxbuffer_memory(struct mgsl_struct *info)
 {
 	info->intermediate_rxbuffer = kmalloc(info->max_frame_size, GFP_KERNEL | GFP_DMA);
 	if ( info->intermediate_rxbuffer == NULL )
@@ -4013,7 +4011,7 @@
  * 
  * Return Value:	None
  */
-void mgsl_free_intermediate_rxbuffer_memory(struct mgsl_struct *info)
+static void mgsl_free_intermediate_rxbuffer_memory(struct mgsl_struct *info)
 {
 	if ( info->intermediate_rxbuffer )
 		kfree(info->intermediate_rxbuffer);
@@ -4035,7 +4033,7 @@
  *
  * Return Value:	0 if success, otherwise -ENOMEM
  */
-int mgsl_alloc_intermediate_txbuffer_memory(struct mgsl_struct *info)
+static int mgsl_alloc_intermediate_txbuffer_memory(struct mgsl_struct *info)
 {
 	int i;
 
@@ -4066,7 +4064,7 @@
  *
  * Return Value:	None
  */
-void mgsl_free_intermediate_txbuffer_memory(struct mgsl_struct *info)
+static void mgsl_free_intermediate_txbuffer_memory(struct mgsl_struct *info)
 {
 	int i;
 
@@ -4098,7 +4096,7 @@
  * 			into adapter's tx dma buffer,
  * 			0 otherwise
  */
-int load_next_tx_holding_buffer(struct mgsl_struct *info)
+static int load_next_tx_holding_buffer(struct mgsl_struct *info)
 {
 	int ret = 0;
 
@@ -4144,7 +4142,7 @@
  *
  * Return Value:	1 if able to store, 0 otherwise
  */
-int save_tx_buffer_request(struct mgsl_struct *info,const char *Buffer, unsigned int BufferSize)
+static int save_tx_buffer_request(struct mgsl_struct *info,const char *Buffer, unsigned int BufferSize)
 {
 	struct tx_holding_buffer *ptx;
 
@@ -4163,7 +4161,7 @@
 	return 1;
 }
 
-int mgsl_claim_resources(struct mgsl_struct *info)
+static int mgsl_claim_resources(struct mgsl_struct *info)
 {
 	if (request_region(info->io_base,info->io_addr_size,"synclink") == NULL) {
 		printk( "%s(%d):I/O address conflict on device %s Addr=%08X\n",
@@ -4243,7 +4241,7 @@
 
 }	/* end of mgsl_claim_resources() */
 
-void mgsl_release_resources(struct mgsl_struct *info)
+static void mgsl_release_resources(struct mgsl_struct *info)
 {
 	if ( debug_level >= DEBUG_LEVEL_INFO )
 		printk( "%s(%d):mgsl_release_resources(%s) entry\n",
@@ -4297,7 +4295,7 @@
  * Arguments:		info	pointer to device instance data
  * Return Value:	None
  */
-void mgsl_add_device( struct mgsl_struct *info )
+static void mgsl_add_device( struct mgsl_struct *info )
 {
 	info->next_device = NULL;
 	info->line = mgsl_device_count;
@@ -4363,7 +4361,7 @@
  * Arguments:		none
  * Return Value:	pointer to mgsl_struct if success, otherwise NULL
  */
-struct mgsl_struct* mgsl_allocate_device(void)
+static struct mgsl_struct* mgsl_allocate_device(void)
 {
 	struct mgsl_struct *info;
 	
@@ -4582,7 +4580,7 @@
  *
  *    None
  */
-void usc_RTCmd( struct mgsl_struct *info, u16 Cmd )
+static void usc_RTCmd( struct mgsl_struct *info, u16 Cmd )
 {
 	/* output command to CCAR in bits <15..11> */
 	/* preserve bits <10..7>, bits <6..0> must be zero */
@@ -4609,7 +4607,7 @@
  *
  *       None
  */
-void usc_DmaCmd( struct mgsl_struct *info, u16 Cmd )
+static void usc_DmaCmd( struct mgsl_struct *info, u16 Cmd )
 {
 	/* write command mask to DCAR */
 	outw( Cmd + info->mbre_bit, info->io_base );
@@ -4636,7 +4634,7 @@
  *    None
  *
  */
-void usc_OutDmaReg( struct mgsl_struct *info, u16 RegAddr, u16 RegValue )
+static void usc_OutDmaReg( struct mgsl_struct *info, u16 RegAddr, u16 RegValue )
 {
 	/* Note: The DCAR is located at the adapter base address */
 	/* Note: must preserve state of BIT8 in DCAR */
@@ -4665,7 +4663,7 @@
  *    The 16-bit value read from register
  *
  */
-u16 usc_InDmaReg( struct mgsl_struct *info, u16 RegAddr )
+static u16 usc_InDmaReg( struct mgsl_struct *info, u16 RegAddr )
 {
 	/* Note: The DCAR is located at the adapter base address */
 	/* Note: must preserve state of BIT8 in DCAR */
@@ -4692,7 +4690,7 @@
  *    None
  *
  */
-void usc_OutReg( struct mgsl_struct *info, u16 RegAddr, u16 RegValue )
+static void usc_OutReg( struct mgsl_struct *info, u16 RegAddr, u16 RegValue )
 {
 	outw( RegAddr + info->loopback_bits, info->io_base + CCAR );
 	outw( RegValue, info->io_base + CCAR );
@@ -4717,7 +4715,7 @@
  *
  *    16-bit value read from register
  */
-u16 usc_InReg( struct mgsl_struct *info, u16 RegAddr )
+static u16 usc_InReg( struct mgsl_struct *info, u16 RegAddr )
 {
 	outw( RegAddr + info->loopback_bits, info->io_base + CCAR );
 	return inw( info->io_base + CCAR );
@@ -4731,7 +4729,7 @@
  * Arguments:		info    pointer to device instance data
  * Return Value: 	NONE
  */
-void usc_set_sdlc_mode( struct mgsl_struct *info )
+static void usc_set_sdlc_mode( struct mgsl_struct *info )
 {
 	u16 RegValue;
 	int PreSL1660;
@@ -5311,7 +5309,7 @@
  *			enable	1 = enable loopback, 0 = disable
  * Return Value:	None
  */
-void usc_enable_loopback(struct mgsl_struct *info, int enable)
+static void usc_enable_loopback(struct mgsl_struct *info, int enable)
 {
 	if (enable) {
 		/* blank external TXD output */
@@ -5375,7 +5373,7 @@
  *
  * Return Value:	None
  */
-void usc_enable_aux_clock( struct mgsl_struct *info, u32 data_rate )
+static void usc_enable_aux_clock( struct mgsl_struct *info, u32 data_rate )
 {
 	u32 XtalSpeed;
 	u16 Tc;
@@ -5432,7 +5430,7 @@
  *
  * Return Value: None
  */
-void usc_process_rxoverrun_sync( struct mgsl_struct *info )
+static void usc_process_rxoverrun_sync( struct mgsl_struct *info )
 {
 	int start_index;
 	int end_index;
@@ -5571,7 +5569,7 @@
  * Arguments:		info	pointer to device instance data
  * Return Value:	None
  */
-void usc_stop_receiver( struct mgsl_struct *info )
+static void usc_stop_receiver( struct mgsl_struct *info )
 {
 	if (debug_level >= DEBUG_LEVEL_ISR)
 		printk("%s(%d):usc_stop_receiver(%s)\n",
@@ -5604,7 +5602,7 @@
  * Arguments:		info	pointer to device instance data
  * Return Value:	None
  */
-void usc_start_receiver( struct mgsl_struct *info )
+static void usc_start_receiver( struct mgsl_struct *info )
 {
 	u32 phys_addr;
 	
@@ -5668,7 +5666,7 @@
  * Arguments:		info	pointer to device instance data
  * Return Value:	None
  */
-void usc_start_transmitter( struct mgsl_struct *info )
+static void usc_start_transmitter( struct mgsl_struct *info )
 {
 	u32 phys_addr;
 	unsigned int FrameSize;
@@ -5774,7 +5772,7 @@
  * Arguments:		info	pointer to device isntance data
  * Return Value:	None
  */
-void usc_stop_transmitter( struct mgsl_struct *info )
+static void usc_stop_transmitter( struct mgsl_struct *info )
 {
 	if (debug_level >= DEBUG_LEVEL_ISR)
 		printk("%s(%d):usc_stop_transmitter(%s)\n",
@@ -5803,7 +5801,7 @@
  * Arguments:		info	pointer to device extension (instance data)
  * Return Value:	None
  */
-void usc_load_txfifo( struct mgsl_struct *info )
+static void usc_load_txfifo( struct mgsl_struct *info )
 {
 	int Fifocount;
 	u8 TwoBytes[2];
@@ -5860,7 +5858,7 @@
  * Arguments:		info	pointer to device instance data
  * Return Value:	None
  */
-void usc_reset( struct mgsl_struct *info )
+static void usc_reset( struct mgsl_struct *info )
 {
 	if ( info->bus_type == MGSL_BUS_TYPE_PCI ) {
 		int i;
@@ -5974,7 +5972,7 @@
  * Arguments:		info		pointer to device instance data
  * Return Value:	None
  */
-void usc_set_async_mode( struct mgsl_struct *info )
+static void usc_set_async_mode( struct mgsl_struct *info )
 {
 	u16 RegValue;
 
@@ -6167,7 +6165,7 @@
  * Arguments:		info		pointer to device instance data
  * Return Value:	None
  */
-void usc_loopback_frame( struct mgsl_struct *info )
+static void usc_loopback_frame( struct mgsl_struct *info )
 {
 	int i;
 	unsigned long oldmode = info->params.mode;
@@ -6235,7 +6233,7 @@
  * Arguments:		info	pointer to adapter info structure
  * Return Value:	None
  */
-void usc_set_sync_mode( struct mgsl_struct *info )
+static void usc_set_sync_mode( struct mgsl_struct *info )
 {
 	usc_loopback_frame( info );
 	usc_set_sdlc_mode( info );
@@ -6258,7 +6256,7 @@
  * Arguments:		info	pointer to device instance data
  * Return Value:	None
  */
-void usc_set_txidle( struct mgsl_struct *info )
+static void usc_set_txidle( struct mgsl_struct *info )
 {
 	u16 usc_idle_mode = IDLEMODE_FLAGS;
 
@@ -6321,7 +6319,7 @@
  * Arguments:		info	pointer to device instance data
  * Return Value:	None
  */
-void usc_get_serial_signals( struct mgsl_struct *info )
+static void usc_get_serial_signals( struct mgsl_struct *info )
 {
 	u16 status;
 
@@ -6357,7 +6355,7 @@
  * Arguments:		info	pointer to device instance data
  * Return Value:	None
  */
-void usc_set_serial_signals( struct mgsl_struct *info )
+static void usc_set_serial_signals( struct mgsl_struct *info )
 {
 	u16 Control;
 	unsigned char V24Out = info->serial_signals;
@@ -6389,7 +6387,7 @@
  *					0 disables the AUX clock.
  * Return Value:	None
  */
-void usc_enable_async_clock( struct mgsl_struct *info, u32 data_rate )
+static void usc_enable_async_clock( struct mgsl_struct *info, u32 data_rate )
 {
 	if ( data_rate )	{
 		/*
@@ -6499,7 +6497,7 @@
  * Arguments:		info	pointer to device instance data
  * Return Value:	None
  */
-void mgsl_reset_tx_dma_buffers( struct mgsl_struct *info )
+static void mgsl_reset_tx_dma_buffers( struct mgsl_struct *info )
 {
 	unsigned int i;
 
@@ -6525,7 +6523,7 @@
  * Arguments:		info	pointer to device instance data
  * Return Value:	number of free tx dma buffers
  */
-int num_free_tx_dma_buffers(struct mgsl_struct *info)
+static int num_free_tx_dma_buffers(struct mgsl_struct *info)
 {
 	return info->tx_buffer_count - info->tx_dma_buffers_used;
 }
@@ -6540,7 +6538,7 @@
  * Arguments:		info	pointer to device instance data
  * Return Value:	None
  */
-void mgsl_reset_rx_dma_buffers( struct mgsl_struct *info )
+static void mgsl_reset_rx_dma_buffers( struct mgsl_struct *info )
 {
 	unsigned int i;
 
@@ -6568,7 +6566,7 @@
  * 
  * Return Value:	None
  */
-void mgsl_free_rx_frame_buffers( struct mgsl_struct *info, unsigned int StartIndex, unsigned int EndIndex )
+static void mgsl_free_rx_frame_buffers( struct mgsl_struct *info, unsigned int StartIndex, unsigned int EndIndex )
 {
 	int Done = 0;
 	DMABUFFERENTRY *pBufEntry;
@@ -6611,7 +6609,7 @@
  * Arguments:	 	info	pointer to device extension
  * Return Value:	1 if frame returned, otherwise 0
  */
-int mgsl_get_rx_frame(struct mgsl_struct *info)
+static int mgsl_get_rx_frame(struct mgsl_struct *info)
 {
 	unsigned int StartIndex, EndIndex;	/* index of 1st and last buffers of Rx frame */
 	unsigned short status;
@@ -6810,7 +6808,7 @@
  * Arguments:	 	info	pointer to device extension
  * Return Value:	1 if frame returned, otherwise 0
  */
-int mgsl_get_raw_rx_frame(struct mgsl_struct *info)
+static int mgsl_get_raw_rx_frame(struct mgsl_struct *info)
 {
 	unsigned int CurrentIndex, NextIndex;
 	unsigned short status;
@@ -6975,8 +6973,8 @@
  * 
  * Return Value: 	None
  */
-void mgsl_load_tx_dma_buffer(struct mgsl_struct *info, const char *Buffer,
-	 unsigned int BufferSize)
+static void mgsl_load_tx_dma_buffer(struct mgsl_struct *info,
+		const char *Buffer, unsigned int BufferSize)
 {
 	unsigned short Copycount;
 	unsigned int i = 0;
@@ -7052,7 +7050,7 @@
  * Arguments:		info	pointer to device instance data
  * Return Value:		TRUE if test passed, otherwise FALSE
  */
-BOOLEAN mgsl_register_test( struct mgsl_struct *info )
+static BOOLEAN mgsl_register_test( struct mgsl_struct *info )
 {
 	static unsigned short BitPatterns[] =
 		{ 0x0000, 0xffff, 0xaaaa, 0x5555, 0x1234, 0x6969, 0x9696, 0x0f0f };
@@ -7108,7 +7106,7 @@
  * Arguments:		info	pointer to device instance data
  * Return Value:	TRUE if test passed, otherwise FALSE
  */
-BOOLEAN mgsl_irq_test( struct mgsl_struct *info )
+static BOOLEAN mgsl_irq_test( struct mgsl_struct *info )
 {
 	unsigned long EndTime;
 	unsigned long flags;
@@ -7163,7 +7161,7 @@
  * Arguments:		info	pointer to device instance data
  * Return Value:	TRUE if test passed, otherwise FALSE
  */
-BOOLEAN mgsl_dma_test( struct mgsl_struct *info )
+static BOOLEAN mgsl_dma_test( struct mgsl_struct *info )
 {
 	unsigned short FifoLevel;
 	unsigned long phys_addr;
@@ -7455,7 +7453,7 @@
  * Arguments:		info	pointer to device instance data
  * Return Value:	0 if success, otherwise -ENODEV
  */
-int mgsl_adapter_test( struct mgsl_struct *info )
+static int mgsl_adapter_test( struct mgsl_struct *info )
 {
 	if ( debug_level >= DEBUG_LEVEL_INFO )
 		printk( "%s(%d):Testing device %s\n",
@@ -7497,7 +7495,7 @@
  * Arguments:		info	pointer to device instance data
  * Return Value:	TRUE if test passed, otherwise FALSE
  */
-BOOLEAN mgsl_memory_test( struct mgsl_struct *info )
+static BOOLEAN mgsl_memory_test( struct mgsl_struct *info )
 {
 	static unsigned long BitPatterns[] = { 0x0, 0x55555555, 0xaaaaaaaa,
 											0x66666666, 0x99999999, 0xffffffff, 0x12345678 };
@@ -7578,7 +7576,7 @@
  *
  * Return Value:	None
  */
-void mgsl_load_pci_memory( char* TargetPtr, const char* SourcePtr, 
+static void mgsl_load_pci_memory( char* TargetPtr, const char* SourcePtr, 
 	unsigned short count )
 {
 	/* 16 32-bit writes @ 60ns each = 960ns max latency on local bus */
@@ -7600,7 +7598,7 @@
 
 }	/* End Of mgsl_load_pci_memory() */
 
-void mgsl_trace_block(struct mgsl_struct *info,const char* data, int count, int xmit)
+static void mgsl_trace_block(struct mgsl_struct *info,const char* data, int count, int xmit)
 {
 	int i;
 	int linecount;
@@ -7640,7 +7638,7 @@
  * Arguments:	context		pointer to device instance data
  * Return Value:	None
  */
-void mgsl_tx_timeout(unsigned long context)
+static void mgsl_tx_timeout(unsigned long context)
 {
 	struct mgsl_struct *info = (struct mgsl_struct*)context;
 	unsigned long flags;
@@ -7694,7 +7692,7 @@
 /* release the line by echoing RxD to TxD
  * upon completion of a transmit frame
  */
-void usc_loopmode_send_done( struct mgsl_struct * info )
+static void usc_loopmode_send_done( struct mgsl_struct * info )
 {
  	info->loopmode_send_done_requested = FALSE;
  	/* clear CMR:13 to 0 to start echoing RxData to TxData */
@@ -7704,7 +7702,7 @@
 
 /* abort a transmit in progress while in HDLC LoopMode
  */
-void usc_loopmode_cancel_transmit( struct mgsl_struct * info )
+static void usc_loopmode_cancel_transmit( struct mgsl_struct * info )
 {
  	/* reset tx dma channel and purge TxFifo */
  	usc_RTCmd( info, RTCmd_PurgeTxFifo );
@@ -7716,7 +7714,7 @@
  * is an Insert Into Loop action. Upon receipt of a GoAhead sequence (RxAbort)
  * we must clear CMR:13 to begin repeating TxData to RxData
  */
-void usc_loopmode_insert_request( struct mgsl_struct * info )
+static void usc_loopmode_insert_request( struct mgsl_struct * info )
 {
  	info->loopmode_insert_requested = TRUE;
  
@@ -7733,18 +7731,11 @@
 
 /* return 1 if station is inserted into the loop, otherwise 0
  */
-int usc_loopmode_active( struct mgsl_struct * info)
+static int usc_loopmode_active( struct mgsl_struct * info)
 {
  	return usc_InReg( info, CCSR ) & BIT7 ? 1 : 0 ;
 }
 
-/* return 1 if USC is in loop send mode, otherwise 0
- */
-int usc_loopmode_send_active( struct mgsl_struct * info )
-{
-	return usc_InReg( info, CCSR ) & BIT6 ? 1 : 0 ;
-}			  
-
 #ifdef CONFIG_HDLC
 
 /**

